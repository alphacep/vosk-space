. ./path_train_with_27.sh
. ./cmd.sh

data_set=train
data_dir=data/${data_set}
ali_dir=exp/${data_set}_ali
src_dir=exp/nnet3/tdnn_sp
dir=${src_dir}_${data_set}

num_jobs_initial=1
num_jobs_final=1
num_epochs=1
initial_effective_lrate=0.000005
final_effective_lrate=0.000001
minibatch_size=128

stage=1
train_stage=-10
nj=1

if [ $stage -le 1 ]; then
  steps/make_mfcc.sh \
    --cmd "$train_cmd" --nj $nj \
    ${data_dir} exp/make_mfcc/${data_set} mfcc
  steps/compute_cmvn_stats.sh ${data_dir} exp/make_mfcc/${data_set} mfcc || exit 1;

  utils/fix_data_dir.sh ${data_dir} || exit 1;
  # extract mfcc_hires for AM finetuning
  utils/copy_data_dir.sh ${data_dir} ${data_dir}_hires
  
  rm -f ${data_dir}_hires/{cmvn.scp,feats.scp}
  # utils/data/perturb_data_dir_volume.sh ${data_dir}_hires || exit 1;
  steps/make_mfcc.sh \
    --cmd "$train_cmd" --nj $nj --mfcc-config conf/mfcc_hires.conf \
    ${data_dir}_hires exp/make_mfcc/${data_set}_hires mfcc_hires
  
  steps/compute_cmvn_stats.sh ${data_dir}_hires exp/make_mfcc/${data_set}_hires mfcc_hires
  
  # extract ivector features
  sh steps/online/nnet2/extract_ivectors_online.sh $data_dir ivector exp/nnet3_online/ivectors_test
  
  # extract align features
  sh steps/nnet3/align.sh $data_dir data/lang $ali_dir exp/nnet3/ali
  
  # copy ali.*.gz, in case of *=1, it will be ali.1.gz
  cp exp/nnet3/ali/ali.1.gz $ali_dir/ali.1.gz
fi

echo -----
echo 2
echo -----

if [ $stage -le 2 ]; then
  $train_cmd $dir/log/generate_input_model.log nnet3-am-copy --raw=true "$src_dir/final.mdl" "$dir/input.raw";
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
    --feat-dir ${data_dir}_hires \
    --lang data/lang \
    --ali-dir ${ali_dir} \
    --feat.online-ivector-dir exp/nnet3_online/ivectors_test \
    --egs.frames-per-eg 100 \
    --dir $dir || exit 1;
fi
