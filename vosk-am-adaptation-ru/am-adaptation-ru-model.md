# Vosk-am-adaptation / [DRAFT] + [HELP!]

Fine-Tuning russian-language acoustic model [vosk-model-ru-0.10.zip](https://alphacephei.com/vosk/models/vosk-model-ru-0.10.zip)
# Installing
Installing Kaldi. Build. Download the model.
```bash
# Copy repo
git clone https://github.com/kaldi-asr/kaldi.git

# Enter tools
cd kaldi/tools/ 

# Make
make 

# Enter source and configure
cd ../src
./configure

# Make
make

# Download our repo
cd ../../
git clone https://github.com/SanzharMrz/vosk-space.git
cd vosk-space/vosk-am-adaptation-ru
```

# Download VOSK
First of all, we will get VOSK model and copy some utility scripts from aishell2. We assume that you have _$KALDI_ROOT_ variable.

```bash
# Download VOSK model
echo Downloading vosk-model-ru-0.10 ...
wget https://alphacephei.com/vosk/models/vosk-model-ru-0.10.zip

# Unzip
echo Unzipping vosk-model-ru-0.10
unzip vosk-model-ru-0.10.zip 

# Step into vosk-model
cd vosk-model-ru-0.10/

# Copy files from $KALDI_ROOT
cp -r $KALDI_ROOT/egs/wsj/s5/steps .
cp -r $KALDI_ROOT/egs/wsj/s5/local .
cp -r $KALDI_ROOT/egs/wsj/s5/utils .
```

# Download data
We will test our finetuning script on The M-AILABS Russian Speech [Dataset.](https://www.caito.de/2019/01/the-m-ailabs-speech-dataset/) Especially male/minaev/oblomov/ part, with 9'000 audios on train and 1'000 on test.

```bash
# Download
echo Downloading M-AILABS dataset ...
wget http://www.caito.de/data/Training/stt_tts/ru_RU.tgz

# Untar
echo Untar M-AILABS dataset ...
tar -xvzf ru_RU.tgz
```

# Prepare data
The official guide from Kaldi [data preparation](https://kaldi-asr.org/doc/data_prep.html). There is our parsing [create_data.py](create_data.py) with refference to [JohnDoe](https://github.com/JohnDoe02/kaldi/blob/private/egs/rm/s5/local/prepare_data.py). Parser creates dataset.tsv with columns,  __"File"__, __"Length"__, __"Directory"__, __"Recognition"__ .  Here you should note that __"File"__ is the file name with the full path and some meta, "Length" can be filled with anything, "Directory" is the full path to the folder with the files, "Recognition" is the text from the wav files.

```bash
# Parse data in kaldi format
echo Creating Kaldi format data from ru_RU/by_book/male/minaev/oblomov/ ...
python3 ../create_data.py ru_RU/by_book/male/minaev/oblomov/ $data_dir $test_dir

# Creates data/local/dict, we will use our modified version
sh ../dict_prep.sh

# Creates data/local/lang and data/lang
sh utils/prepare_lang.sh data/local/dict '!SIL' data/local/lang data/lang || exit 1;
```

> If the "segments" file does not exist, the first token on each line of "wav.scp" file is just the utterance id."

Pay attention to the sorting by utterance-id:

> All of these files should be sorted. If they are not sorted, you will get errors when you run the scripts

In addition, you need to check your audio via `sox --i filename`, and if you have cutted wav files and  multichannel, then: 

> The recording side is a concept that relates to telephone conversations where there are two channels, and if not, it's probably safe to use "A". 

In my case, each new wav file is a new record, and there are no segments, so all files with recording-id can be replaced by utterance-id:

*wav.scp*
                                       
![wav.scp](https://user-images.githubusercontent.com/48170101/117793265-e0586180-b26d-11eb-96d3-4614ed6c66c7.png)

*utt2spk*

![utt2spk](https://user-images.githubusercontent.com/48170101/117793486-17c70e00-b26e-11eb-8104-9f13f35ca259.png)

# Create features
The _steps/_, _utils/_ scripts are from the [aishell2](https://github.com/kaldi-asr/kaldi/tree/master/egs/aishell2/s5).
Here is the script we use, [finetuning-am-ru.sh](finetuning-am-ru.sh). Directly a piece of code with feature extraction (possible inaccuracies, worth validating):

```bash
# Compute mfcc
steps/make_mfcc.sh \
  --cmd "$train_cmd" --nj $nj --mfcc-config conf/mfcc.conf \
  ${data_dir} exp/make_mfcc/${data_set} mfcc

# Normalize 
steps/compute_cmvn_stats.sh ${data_dir} exp/make_mfcc/${data_set} mfcc
utils/fix_data_dir.sh ${data_dir} || exit 1;
```

# Create alignments
Process of alignment in our case, based on ivectors extraction, via steps/nnet3/align_lats.sh script with setted parameter _generate_ali_from_lats=true_.

```bash
# Extract ivector features
sh steps/online/nnet2/extract_ivectors_online.sh $data_dir ivector $ivector_dir

# Extract lats with generate_ali_from_lats=true
# [ATTENTION] set ivector variable inside algin_lats.sh script
sh steps/nnet3/align_lats.sh $data_dir data/lang am $ali_dir  
```

# Training
Next, train a copy of the original acoustic model _input.raw_.

```bash
steps/nnet3/train_dnn.py --stage=$train_stage \
  --cmd="$decode_cmd" \
  --feat.cmvn-opts="--norm-means=false --norm-vars=false" \
  --trainer.input-model $dir/input.raw \
  --trainer.num-epochs $num_epochs \
  --trainer.optimization.num-jobs-initial $num_jobs_initial \
  --trainer.optimization.num-jobs-final $num_jobs_final \
  --trainer.optimization.initial-effective-lrate $initial_effective_lrate \
  --trainer.optimization.final-effective-lrate $final_effective_lrate \
  --trainer.optimization.minibatch-size $minibatch_size \
  --feat-dir ${data_dir} \
  --lang data/lang \
  --ali-dir ${ali_dir} \
  --feat.online-ivector-dir $ivector_dir \
  --egs.frames-per-eg 8 \ 
  --dir $dir || exit 1;
```

With the following parameters:
```bash
num_jobs_initial=1
num_jobs_final=1
num_epochs=5
initial_effective_lrate=0.000005
final_effective_lrate=0.000001
minibatch_size=128
```
![training](https://user-images.githubusercontent.com/48170101/117966891-43b5c280-b346-11eb-8cd4-3420b72852e9.png)

After training, in the generated folder for experiments, there will be .mdl model files

![ls](https://user-images.githubusercontent.com/48170101/117951384-ef0a4b80-b335-11eb-9f4e-2d2f9883432f.png)
