. ./cmd.sh

data_set=train
data_dir=data/${data_set}
ali_dir=exp/${data_set}_ali
src_dir=exp/nnet3/tdnn_sp
dir=${src_dir}_${data_set}
ivector_dir=exp/nnet3_online/ivectors_test

num_jobs_initial=1
num_jobs_final=1
num_epochs=1
initial_effective_lrate=0.000025
final_effective_lrate=0.00001
minibatch_size=512

stage=1

train_stage=-10
nj=1

if [ $stage -le 1 ]; then
  
  steps/make_mfcc.sh \
    --cmd "$train_cmd" --nj $nj --mfcc-config conf/mfcc.conf \
    ${data_dir} exp/make_mfcc/${data_set} mfcc

  steps/compute_cmvn_stats.sh ${data_dir} exp/make_mfcc/${data_set} mfcc
  utils/fix_data_dir.sh ${data_dir} || exit 1;
  
  # extract ivector features
  sh steps/online/nnet2/extract_ivectors_online.sh $data_dir ivector ivector_dir
  
  # extract align features
  sh steps/nnet3/align.sh $data_dir data/lang am $ali_dir  
  sh steps/nnet3/align_lats.sh $data_dir data/lang am $ali_dir  

fi

echo -----
echo 2
echo -----

if [ $stage -le 2 ]; then
  utils/run.pl $dir/log/generate_input_model.log nnet3-am-copy --raw=true "am/final.mdl" "$dir/input.raw";
fi

echo -----
echo 3
echo -----

if [ $stage -le 3 ]; then
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
