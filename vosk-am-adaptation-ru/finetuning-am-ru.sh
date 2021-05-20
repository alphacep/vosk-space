data_set=train
test_set=test
data_dir=data/${data_set}
test_dir=data/${test_set}
ali_dir=exp/${data_set}_ali
src_dir=exp/nnet3/tdnn_sp
dir=${src_dir}_${data_set}
ivector_dir=exp/nnet3_online/ivectors_test

. ./cmd.sh

num_jobs_initial=1
num_jobs_final=1
num_epochs=1
initial_effective_lrate=0.000025
final_effective_lrate=0.00001
minibatch_size=512

stage=1

train_stage=-10
nj=1

echo -----
echo 0. Get VOSK model.
echo -----

if [ $stage -le 1 ]; then
  # Download VOSK model
  echo Downloading vosk-model-ru-0.10 ...
  wget https://alphacephei.com/vosk/models/vosk-model-ru-0.10.zip
  
  # Unzip
  echo Unzipping vosk-model-ru-0.10
  unzip vosk-model-ru-0.10.zip 
fi

echo -----
echo 1. Prepare data.
echo -----

if [ $stage -le 2 ]; then
  # Download The M-AILABS Speech Dataset [3.6GB]
  echo Downloading M-AILABS dataset ...
  wget http://www.caito.de/data/Training/stt_tts/ru_RU.tgz
  
  # Untar
  echo Untar M-AILABS dataset ...
  tar -xvzf ru_RU.tgz
  
  # Parse data in kaldi format
  echo Creating Kaldi format data from ru_RU/by_book/male/minaev/oblomov/ ...
  python create_data.py ru_RU/by_book/male/minaev/oblomov/ $data_dir $test_dir
fi

echo -----
echo 2. Create features.
echo -----

if [ $stage -le 3 ]; then
  # Compute mfcc features
  steps/make_mfcc.sh \
    --cmd "$train_cmd" --nj $nj --mfcc-config conf/mfcc.conf \
    ${data_dir} exp/make_mfcc/${data_set} mfcc
   
  # Normalize 
  steps/compute_cmvn_stats.sh ${data_dir} exp/make_mfcc/${data_set} mfcc
  utils/fix_data_dir.sh ${data_dir} || exit 1;
  
  # Extract ivector features
  sh steps/online/nnet2/extract_ivectors_online.sh $data_dir ivector ivector_dir
  
  # Extract align features
  sh steps/nnet3/align.sh $data_dir data/lang am $ali_dir
  
  # Extract lats with generate_ali_from_lats=true
  sh steps/nnet3/align_lats.sh $data_dir data/lang am $ali_dir  
fi

echo -----
echo 3. Copy model.
echo -----

if [ $stage -le 4 ]; then
  # Copy model in raw format
  utils/run.pl $dir/log/generate_input_model.log nnet3-am-copy --raw=true "am/final.mdl" "$dir/input.raw";
fi

echo -----
echo 4. Train model.
echo -----

if [ $stage -le 5 ]; then
  # Train model
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
    --feat-dir ${data_dir}\
    --lang data/lang \
    --ali-dir ${ali_dir} \
    --feat.online-ivector-dir ivector_dir
    --egs.frames-per-eg 8 \
    --dir $dir || exit 1;
fi
