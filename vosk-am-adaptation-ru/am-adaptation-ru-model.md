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

# Download and unzip model
cd ../
wget https://alphacephei.com/vosk/models/vosk-model-ru-0.10.zip
unzip vosk-model-ru-0.10.zip
```

# Prepare data
The official guide from Kaldi [Data Preparation](https://kaldi-asr.org/doc/data_prep.html).  There is also a code from JohnDoe, for [RM](https://catalog.ldc.upenn.edu/LDC93S3C) dataset, where [prepare_data.py](https://github.com/JohnDoe02/kaldi/blob/private/egs/rm/s5/local/prepare_data.py) parses
some dataset.tsv with columns,  __"File"__, __"Length"__, __"Directory"__, __"Recognition"__ , Here you should note that __"File"__ is the file name with the full path and some meta, "Length" can be filled with anything, "Directory" is the full path to the folder with the files, "Recognition" is the text from the wav files.

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

*spk2gender*

![spk2gender](https://user-images.githubusercontent.com/48170101/117793875-7e4c2c00-b26e-11eb-9665-d9a4049fa0c8.png)

# Create features

The steps/scripts from the [CVTE finetuning](https://github.com/zhaoyi2/CVTE_chain_model_finetune/tree/master/steps) recipe are used to extract mel features and normalize them, **MAYBE** we should use the steps from kaldi [aishell2](https://github.com/kaldi-asr/kaldi/tree/master/egs/aishell2/s5), can this __affect__ the preparation of features? As for the finetune script, they are combined into one sh [finetune_tdnn_1a.sh](https://github.com/kaldi-asr/kaldi/blob/master/egs/aishell2/s5/local/nnet3/tuning/finetune_tdnn_1a.sh), this pipeline is recommended in alphacephei [model adaptation](https://alphacephei.com/vosk/adaptation) 

Here is the script we use, [ft.sh](ft.sh). Directly a piece of code with data preparation (possible inaccuracies, worth validating):

```bash
# Compute mfcc 
steps/make_mfcc.sh \
  --cmd "$train_cmd" --nj $nj \
  ${data_dir} exp/make_mfcc/${data_set} mfcc
  
# Normalization
steps/compute_cmvn_stats.sh ${data_dir} exp/make_mfcc/${data_set} mfcc || exit 1;

utils/fix_data_dir.sh ${data_dir} || exit 1;
# extract mfcc_hires for AM finetuning
utils/copy_data_dir.sh ${data_dir} ${data_dir}_hires

rm -f ${data_dir}_hires/{cmvn.scp,feats.scp}
steps/make_mfcc.sh \
  --cmd "$train_cmd" --nj $nj --mfcc-config conf/mfcc_hires.conf \
  ${data_dir}_hires exp/make_mfcc/${data_set}_hires mfcc_hires

steps/compute_cmvn_stats.sh ${data_dir}_hires exp/make_mfcc/${data_set}_hires mfcc_hires

# Compute ivector
sh steps/online/nnet2/extract_ivectors_online.sh $data_dir ivector exp/nnet3_online/ivectors_test

# Align with ivector
# By the way, in align.sh there is our modification on the size of the beam, in order to maintain as many hypotheses as possible# beam=1000
# retry_beam=10000

sh steps/nnet3/align.sh $data_dir data/lang $ali_dir exp/nnet3/ali

# Moving the counted ali
cp exp/nnet3/ali/ali.1.gz $ali_dir/ali.1.gz
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
  --feat-dir ${data_dir}_hires \
  --lang data/lang \
  --ali-dir ${ali_dir} \
  --feat.online-ivector-dir exp/nnet3_online/ivectors_test \
  --egs.frames-per-eg 100 \ # может ли здесь быть проблема с объемом frames
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

# Inference

Decoding process is the stumbling block in our case. In vosk-api, there is a script for [inference](https://github.com/alphacep/vosk-api/blob/master/python/test/transcribe_scp.py). Which we actually use as a _py_ command. 

__Case: 1__ Copy one of the aforementioned .mdl files into the _am_ folder of the downloaded vosk-model. Let's say final.mdl (What is typical, during the training frame-per-eg was equal to 100). And we get:

![inference_final](https://user-images.githubusercontent.com/48170101/117957473-eddc1d00-b33b-11eb-9731-36df023a1219.png)

__Case: 2__ Copy any of the other models. For example combined.mdl:

![inference_combined](https://user-images.githubusercontent.com/48170101/117958178-95f1e600-b33c-11eb-8955-74594648fb51.png)

__Case: 3__ 100.mdl:

![100.mdl](https://user-images.githubusercontent.com/48170101/117959014-6becf380-b33d-11eb-9358-ed843393abcd.png)

__Case: 4__ Model with same params and 1 epoch training (much better):

![final.mdl 1 epoch](https://user-images.githubusercontent.com/48170101/118093894-e5451e80-b3ef-11eb-9a7c-3e9927d685b1.png)

__A little more meta information:__

![image](https://user-images.githubusercontent.com/48170101/117958791-30eac000-b33d-11eb-93f6-688b09f6e698.png)
