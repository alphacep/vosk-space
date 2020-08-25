---
layout: default
title: Model adaptation for VOSK
---

There are many issues which can lead to bad accuracy from model
mismatches to software bugs. See [accuracy](accuracy) guide for more
detailed information on how to debug the accuracy problems. Once you
figured out the reason is in the model mismatch you can try to adapt
existing models to get better performance.

Please note that we focus on the models which work equally well in any conditions
and we spend a lot of time on training them, so training from scratch is
very rarely a great solution. In most cases you'd better adapt the existing
model than train a new one.

There are four levels of adaptation you can apply:

 * Update our small models in runtime with the list of words to recognize
 * Update our small models offline with the language model from texts
 * Update language model and the dictionary inside the big model
 * Finetune acoustic model on your data

Here we cover those methods:

## Updating recognizer vocabulary in runtime

Vosk-API supports online modification of the vocabulary. See the [demo
code](https://github.com/alphacep/vosk-api/blob/master/python/example/test_words.py)
for details.

Note that big models with static graphs do not support this modification,
you need a model with dynamic graph.

## Updating the language model

The Kaldi model used in Vosk is compiled from 3 data sources:

  * dictionary
  * acoustic model
  * language model

You can rebuild all three with different level of effort, but sometimes you just
need to adjust the probability of the words to improve the recognition. For
that it is enough to recompile the language model from the text. To do that

1. Take a text that reflects the speech you want to recognize

2. Remove punctuation, convert everything to the lowercase, you can do it with a python script

3. Build openfst and opengrm inside kaldi
```
export KALDI_ROOT=`pwd`/kaldi
git clone https://github.com/kaldi-asr/kaldi
cd kaldi/tools
make
# install all required dependencies and repeat `make` if needed
extras/install_opengrm.sh
```
4. Now lets build a grammar
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

For more details see OpenGRM documentation <http://www.opengrm.org/twiki/bin/view/GRM/NGramLibrary>

You can not introduce new words this way, that is something we will cover later.

## Updating words and the vocabulary in the big models

You can rebuild the graph in the big models. For that you need to do the following:

1. Prepare the lexicon in the Kaldi format
2. Prepare the langauge model with the generic one interpolated with the domain-specific one
3. Compile lexicon
4. Compile the graph
5. Replace graph inside the model

For more detailed guide see [this post](https://chrisearch.wordpress.com/2017/03/11/speech-recognition-using-kaldi-extending-and-using-the-aspire-model/).

## Adapting the acoustic model with finetuning

Adapting the acoustic model is also possible with about 1 hour of data. You can follow 
[this issue](https://github.com/daanzu/kaldi-active-grammar/issues/33) for details. 

Basically you need to collect the data, put it in the Kaldi format, then run 
[kaldi script](https://github.com/kaldi-asr/kaldi/blob/master/egs/aishell2/s5/local/nnet3/tuning/finetune_tdnn_1a.sh).

More detailed documentation of the finetuning might be helpful, we do not
have it yet. Corresponding issue is tracked at [vosk-api
issue](https://github.com/alphacep/vosk-api/issues/185).
