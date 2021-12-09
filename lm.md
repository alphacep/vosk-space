---
layout: default
title: VOSK language model adaptation
permalink: /lm
---

# Vosk Language Model Adaptation

How to add words to Vosk model.

## Information sources in speech recognition

The knowledge representation in speech recognition is an open question.

Traditionally Vosk models compile the following data sources to build recognition graph:

   * Acoustic model - model of sounds of the language
   * Language model - model of word sequences
   * Phonetic dictionary - model of the decomposition on words to sounds

Such separation of aspects has advantages and disadvantages:

   * You can quickly replace the knowledge source, for example, you can introduce a new word with non-standard pronunciation (a technical term maybe)
   * You can train your model on one domain and use for another domain just by replacing language model
   * You can tune acoustic model separately
   * System can be compact and can learn from pure texts
   * Words are compiled statically and it is not easy to introduce new words

Newer systems use a neural network which compiles both language model, pronunciation and acoustic model into a single monolithic model. Examples are Transformers, Conformers, RNN-T and so on

   * System is more accurate on the data it is trained with since it learns more complex data dependencies
   * Decoding is even faster
   * You do not have specify the phonetic dictionary
   * Cross-domain transfer is more complicated, to introduce a new word you have to apply complex architecture tricks or you have to train on audio data. People use text-to-speech to create recordings of required words and then adapt the neural network using the recordings (not easy).
   * It is extremely complex to learn on big amount of data

It is an open research subject on which method is better. Maybe a combination of the approaches could win. 

For now, the Vosk approach makes sense for many domain-oriented tasks. For example, if you need to recognize some medical texts, you just take the generic acoustic model and compile it with the medical domain language model and you get much better recognition than the monolithic end-to-end approach. On the other hand, if you have a lot of medical data, the end-to-end approach may shine.


## Modification of information sources in Vosk model

### Phonetic dictionary

A phonetic dictionary provides the system with a mapping of vocabulary words to sequences of phonemes. It is a simple text file that might look like this:

```
hello H EH L OW
world W ER L D
how H AW
```

A dictionary can also contain alternative pronunciations.

```
the TH IH
the TH AH
```

There are various phonesets to represent phones, such as IPA or SAMPA.
Vosk does not yet require you to use any well-known phoneset, moreover,
it prefers to use letter-only phone names without special symbols for
readability. You can use multi-letter symbols too like `AX`, some people
use symbols like `$` or `%` but they usually make the dictionary less
readable. 

Russian dictionary has variations of phones with stress:

```
аборигенами a0 b o0 rj i0 gj e1 n a0 mj i0
аборигенах a0 b o0 rj i0 gj e1 n a0 h
аборигените a0 b o0 rj i0 gj e1 nj i0 tj e0
```

Sometimes stress is marked with an apostrophe after the phone symbol.

There are multilingual acoustic models which include phones from
different languages together.

A dictionary should contain all the words you are interested in,
otherwise the recognizer will not be able to recognize them. Since sounds
of the language are contained in the acoustic model you can only use the
phoneset of the model to represent the words. You can not use other
phones which are missing in the acoustic model, the graph will not
compile.

There is no need to remove unused words from the dictionary unless you
want to save memory, extra words in the dictionary do not affect
accuracy.

#### Extending the dictionary

If you want to recognize new words you need to add them to the dictionary. You can do it in many ways:
   * Pick them from a larger hand-verified dictionary. There are few of them
   * Use special machine learning library (usually called g2p which is grapheme to phoneme)
   * Add them manually following the sounds of the word

Large hand-curated dictionaries are very rare, moreover, new words like “covid” and abbreviations appear all the time, so the first variant is not very practical.

There are several g2p packages to choose from:

#### Script-based packages

There are some rule-based tools like espeak which can predict
pronunciation. For some languages it is enough to use rules. Moreover,
you can bootstrap the dictionary with rules and then simply extend it
with machine-learning g2p tool.

#### Phonetisaurus

Phonetisaurus <https://pypi.org/project/phonetisaurus/> is the simple WFST
(HMM-based) toolkit which enables fast training and almost accurate
prediction

The scripts to train phonetisaurus models are inside the model
compilation package. Pretrained g2p modes are often provided inside model
packages. Once phonetisaurus is compiled, prediction for the new words is
simple method invocation or a command line tool invocation. The
prediction is performed inside a Python script.

#### Transformer-based G2P

There are few neural-network based G2P tools with transformers, like
<https://github.com/cmusphinx/g2p-seq2seq> or
<https://github.com/Kyubyong/g2p> They are usually slower to train and not
much accurate than phonetisaurus. Still, you can use them if you need
best accuracy.

#### Manual review

Even with advanced neural models g2p prediction often fails and produces suboptimal results. 
It helps to create 2-3 variants for a word and add them all to the dictionary.

In general, g2p-created dictionaries must be reviewed manually. For many
special cases if a word is not recognized properly during decoding you
need to review the dictionary entry for it. Big problems usually occur
for non-standard words like foreign names or abbreviations

For complex words one can write the transcription in a text editor just
by looking at the similar words in the dictionary. It is often easy to
figure out which symbols to use.

#### Automatic prediction from spoken data

Kaldi has scripts to pick the proper pronunciation variants of unknown words from the data, it is a tool for advanced users.

### Language model

Language model here might be represented as a following:

   * Dynamic language model which can be changed in runtime
   * Statically compiled graph
   * Statically compiled graph with big LM rescoring
   * Statically compiled graph with RNNLM rescoring

Each approach has its own advantages and disadvantages and depends on target application. 

   * Dynamic models are compact and good for mobile applications. They also allow to preselect recognition variants with grammars.
   * Static graphs require more memory, but they are faster and better for servers. Still only relatively small LMs can be compiled statically, about 100Mb size, certainly not few Gb.
   * Big LM rescoring allows the use of a big LM of size of several gigabytes. 
   * RNNLMs rescoring is slowest, but provides best accuracy due to the use of long context.

### Language modeling toolkits

Language models are usually represented as n-gram models ARPA format.
Essentially it is a huge hidden Markov model trained from text. We can
convert language models to WFST for efficient decoding.

There are several popular model toolkits that operate with language
models - Kenlm, SRILM, MITLM, etc. Unfortunately, only two of them
support critical features:

   * Support for LM interpolation
   * Support for Witten-Bell discounting
   * Support for LM pruning
   * Support for training LM from the huge datasets (1Tb in size)

Those are SRILM and OpenGRM. Popular KenLM toolkit is efficient but
neither supports interpolation nor pruning, so not really recommended.
SRILM has license restrictions, so if you work in production you can only
work with OpenGRM probably. In research we recommend using SRILM.

### Language model adaptation

Language model describes the probabilities of the sequences of words in the text and is required for speech recognition. Generic models are very large (several gigabytes and thus impractical). Most recognition systems have models tuned to the specific domain. For example, the medical language model describes medical dictation. If you are looking for your domain you most likely will have to build the language model for that domain yourself. You can mix that specific domain with generic domain to get some fallback, but specific domain is still needed. Generic language models are created from large texts.

#### Data collection

The first step of language model building is a collection of the data.
The amount of data you need depends on the domain and vocabulary. Usually
for a good model you need a significant amount of texts - at least 100Mb
of text. You can get this text by transcribing existing recordings,
collecting data from the web, or generating it artificially with the
scripts. The most valuable data is real-life data anyway. 

While collecting the texts or creating the texts you need to take in mind
that you are trying to keep the target distribution in your model. So the
frequencies of the words in the model should match the distribution. For
example, if you want to recognize songs, you need to repeat songs or
signer names according to their popularity, not just list them. With the
repeats, you’ll favor more popular songs in the final model.

#### Text cleanup

Once data is collected it must be cleaned - punctuation removed,
sentences split on lines, numbers expanded to text representation. This
can be done with scripting languages like Python.

#### Train/test separation

In machine learning it is practical to control the quality of the model you build. For that you need to separate the test set from the training set and use the test set for evaluation. The practical split is 1 to 10.
The metric to use for evaluation is called perplexity. It controls the quality of the language model. The smaller perplexity is, the smaller is WER. You can calculate perplexity with SRILM:

```
ngram -lm your.lm -ppl test.txt
```

Most other toolkits can also calculate perplexity.

Another parameter is OOV rate. SRILM also prints that with the `-ppl`
option. The OOV rate should not be large, the WER because of OOV is
usually double the OOV rate. For example if you have 3% OOV rate you add
an extra 6% to the WER. So you need to try to minimize OOV rate by
extending your training set.

#### Initial model estimation

Language models can be estimated with different parameters. The parameters depend on a task and require some understanding of underlying algorithms. For example, for book-like texts you need to use Knesser-Ney discounting. For command-like texts you should use Witten-Bell discounting or Absolute discounting. You can try different methods and see which gives better perplexity on a test set.

The command is
```
ngram-count -wbdiscount -text text.txt -lm text.lm
```

#### Language model interpolation with generic model

To improve language model coverage you can mix LM with generic LM created
from web texts.  To perform the mix you need to estimate mixture
parameters. For that you can evaluate model on test set:

```
ngram -lm your.lm -ppl test.txt -debug 2 > your.ppl 
ngram -lm generic.lm -ppl test.txt -debug 2 > generic.ppl
compute-best-mix your.ppl generic.ppl
ngram -lm your.lm -mix-lm generic.lm -lambda <factor from above> -write-lm mixed.lm
```

The mixed LM usually has slightly better perplexity than a specific LM, you can verify the perplexity on a test set.

#### Language model pruning

Most language models are large and it is impractical to use them in a decoder. For example, you can not pack 1Gb LM into WFST decoder. For that reason you can prune them to reduce their size:

```
ngram -lm mixed.lm -prune 1e-8 -write-lm mixed_pruned.lm
```

You can try different factors to get the right model size. Usually the
model must be within 100Mb. You perform decoding with a pruned model
instead of full model. To compensate for reduction of accuracy due to
pruning you still can use the original model in lattice rescoring mode to
get the best accuracy. Most decoders can dump lattices and lattices can
be rescoring with very large models.

After all those steps you need to have the following:

   * Small language model of the size within 100Mb for graph compilation
   * Big language model of size like several Gb for rescoring

### RNNLM adaptation

There are many RNNLM toolkits - fairseq, some pytorch-based standalone
libraries, tensorflow packages. We use native Kaldi RNNLMs for fastest
rescoring. Kaldi RNNLM lattice rescoring provides best accuracy but is
still slow and memory-consuming.

We train RNNLM on a set of GPU computers with a large amount of data. But
the design of the Kaldi RNNLM luckily allows you to add words into them
with a simple graph. This is because words are mapped to subword features
and you don’t need to rebuild the whole RNNLM

The command to modify RNNLM from vocab file is:

```
rnnlm/change_vocab.sh data/lang/words.txt exp/rnnlm_in exp/rnnlm_out
```

If needed, you still can train your own RNNLM or finetune current RNNLM on your texts for best results.

### Notes on other methods

There are many non-authorized tutorials on the internet that do not so nice things. For example, they propose to combine language models with simple perl scripts. It is a bad idea since such a script breaks probability normalization in the language model and might lead to suboptimal results. Also, those tutorials do not mention the approach to rescoring at all.

## Acoustic model

There are scripts for fine-tuning of the acoustic model. Unlike Pytorch models, Kaldi models are not designed for finetuning and the scripts are not easy to set up. We hope to fill this part in the future.

In general, if you have more than 2000 hours of domain-specific data, you’d better train an acoustic model from scratch. In particular, if your audio condition is not very standard (far-field with reverberation, noise, etc).

## Graph compilation

For performance all the models are compiled into more compact structures - FST graphs. If you want to modify them - add new words or adapt to a domain, you run several steps of graph compilation.

Not every Vosk model allows vocabulary modification of the graph. Some like US English, big Russian or German include all necessary files (“tree” file from the model which contains information about phoneme context dependency). Some don’t have required files, you need to contact Alphacephei to get access to them.

### Hardware

Compilation is not very slow, but still requires significant hardware - a Linux server with 32Gb RAM at least and 100Gb of disk space. It is unlikely you can compile a big model in a virtual machine. Small models require less data.

### Software

The following software must be pre-installed on a server:

   * Kaldi
   * SRILM
   * Phonetisaurus (with `pip3 install phonetisaurus`)

In the future we might provide a docker for model compilation, for now you have to compile it yourself.

### Update process

  1. Download the update package, for example:

      Russian - <https://alphacephei.com/vosk/models/vosk-model-ru-0.22-compile.zip>

      US English - <https://alphacephei.com/vosk/models/vosk-model-en-us-0.22-compile.zip>

      German - <https://alphacephei.com/vosk/models/vosk-model-de-0.21-compile.zip>

      French - <https://alphacephei.com/vosk/models/vosk-model-fr-0.6-linto-2.2.0-compile.zip>

      Other language packs are available on request. Please contact us at <mailto:contact@alphacephei.com>

  1. Unpack and properly point to `KALDI_ROOT` in the `path.sh` script
  1. Add your extra texts into `db/extra.txt`
  1. Optionally add manual words phones into `db/extra.dic`
  1. Run `compile-graph.sh`. Update takes about 15 minutes. Watch errors in the process.
  1. Run `decode.sh` to test decoding works successfully. Watch the WER in the decoding folder.
  1. Optionally, check that the g2p properly predicted the phonemes in the end of data/dict/lexicon.txt. If needed, update g2p model with new words.

### Outputs

Depending on your needs you might pick some result files from the compilation folder. Remember, that if you changed the graph you also need to change the rescoring/rnnlm part, otherwise they will go out of sync and accuracy will be low. 

For large model pick the following parts:

   * `exp/chain/tdnn/graph`
   * `data/lang_test_rescore/G.fst` and `data/lang_test_rescore/G.carpa` into `rescore` folder
   * `exp/rnnlm_out` into `rnnlm` folder, you can delete some unnecessary files from `rnnlm` too.

If you don’t want to use RNNLM, delete `rnnlm` folder from the model.

If you don’t want to use rescoring, delete the `rescore` folder from the model, that will save you some runtime memory, but accuracy will be lower.

For small model, just pick the required files from `exp/chain/tdnn/lgraph`.

## Summary and future plans

The process of the graph compilation of the model is automated with the script. We can extend it in the future to make it more straightforward - avoid perl requirements and do everything in pure Python. We are also doing research on runtime graph compilation, we might be able to add the words and phrases to the graph on the fly.
