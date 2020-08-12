---
layout: default
---

## Updating the language model

The Kaldi model used in Vosk is compiled from 3 data sources:

  * dictionary
  * acoustic model
  * language model

You can rebuild all three with different level of effort, but sometimes you just
need to adjust the probability of the words to improve the recognition. For
that it is enough to recompile the language model from the text. To do that

1) Take a text that reflects the speech you want to recognize
2) Remove punctuation, convert everything to the lowercase, you can do it with a python script
3) Build openfst and opengrm inside kaldi

```
export KALDI_ROOT=`pwd`/kaldi
git clone https://github.com/kaldi-asr/kaldi
cd kaldi/tools
make
# install all required dependencies and repeat `make` if needed
extras/install_opengrm.sh
```

4) Now lets build a grammar

```
export PATH=$KALDI_ROOT/tools/openfst/bin:$PATH
export LD_LIBRARY_PATH=$KALDI_ROOT/tools/openfst/lib/fst
cd model
fstsymbols --save_osymbols=words.txt Gr.fst > /dev/null
farcompilestrings --fst_type=compact --symbols=words.txt --keep_symbols text.txt | \
    ngramcount | ngrammake | \
    fstconvert --fst_type=ngram > Gr.new.fst
mv Gr.new.fst Gr.fst
```

Use created Gr.fst instead of standard one in your model.

For more details see OpenGRM documentation http://www.opengrm.org/twiki/bin/view/GRM/NGramLibrary

You can not introduce new words this way, that is something we will cover later.

## Adapting the acoustic model

Adapting the acoustic model is also possible with about 1 hour of data. You can follow 
[this issue](https://github.com/daanzu/kaldi-active-grammar/issues/33) for details. 

Basically you need to collect the data, put it in the Kaldi format, then run 
<https://github.com/kaldi-asr/kaldi/blob/master/egs/aishell2/s5/local/nnet3/tuning/finetune_tdnn_1a.sh>

More detailed setup of the finetuning might be helpful, tracked at [vosk-api issue](https://github.com/alphacep/vosk-api/issues/185).
