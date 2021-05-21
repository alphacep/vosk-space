export KALDI_ROOT=/hdd/conda_kaldi/conda_kaldi_work_dir/kaldi
export LD_LIBRARY_PATH=/hdd/conda_kaldi/conda_kaldi_work_dir/kaldi/tools/openfst-1.6.7/lib/fst:$LD_LIBRARY_PATH
export EXP=/hdd/conda_kaldi/experiment1
export MKL_ROOT=/hdd/conda_kaldi/conda_kaldi_work_dir/mkl_root/mkl/latest
export LC_ALL="en_US.UTF-8"

[ -f $KALDI_ROOT/tools/env.sh ] && . $KALDI_ROOT/tools/env.sh
export PATH=$PWD/utils/:$KALDI_ROOT/tools/openfst-1.6.7/bin:/hdd/conda_kaldi/conda_kaldi_work_dir/kaldi/tools/ngram-1.3.7/src/bin:$LD_LIBRARY_PATH:/hdd/conda_kaldi/conda_kaldi_work_dir/kaldi/tools/openfst-1.6.7/lib/fst:$PWD:$PATH
[ ! -f $KALDI_ROOT/tools/config/common_path.sh ] && echo >&2 "The standard file $KALDI_ROOT/tools/config/common_path.sh is not present -> Exit!" && exit 1
. $KALDI_ROOT/tools/config/common_path.sh
export LC_ALL=C
# setting correct path to python
directory_to_remove=/hdd/conda_kaldi/conda_kaldi_work_dir/kaldi/tools/python
PATH=:$PATH:
PATH=${PATH//:$directory_to_remove:/:}
PATH=${PATH#:}; PATH=${PATH%:}


export PATH=/hdd/conda_kaldi/envs/conda_kaldi_env/bin:$PATH

#conda activate /hdd/conda_kaldi/envs/conda_kaldi_env
