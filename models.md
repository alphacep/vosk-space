---
layout: default
title: VOSK Models
permalink: /models
---

# Models

This is the list of models compatible with Vosk-API.

To add a new model here create an issue on Github.

{:class="table table-bordered"}
| Model                                                                                                     | Size  | Word error rate/Speed | Notes | License    |
|-----------------------------------------------------------------------------------------------------------|-------|------------|-------|------------|
| **English**                                                                                               |       |            |       |            |
| [vosk-model-small-en-us-0.15](http://alphacephei.com/vosk/models/vosk-model-small-en-us-0.15.zip)         |  40M  | 9.85 (librispeech test-clean) 10.38 (tedlium) | Lightweight wideband model for Android and RPi | Apache 2.0 |
| [vosk-model-en-us-0.20](http://alphacephei.com/vosk/models/vosk-model-en-us-0.20.zip)                     |  580M | 6.27 (librispeech test-clean) 6.93 (tedlium) 41.00(callcenter) | Accurate wideband model | Apache 2.0 |
| [vosk-model-en-us-aspire-0.2](https://alphacephei.com/vosk/models/vosk-model-en-us-aspire-0.2.zip)        |  1.4G | 13.64 (librispeech test-clean) 12.89 (tedlium) 33.82(callcenter) | Model for telephony applications, not so nice for wideband | Apache 2.0 |
| **English Other**                                                                                         |       |            |       |            |
| [vosk-model-en-us-daanzu-20200905](https://alphacephei.com/vosk/models/vosk-model-en-us-daanzu-20200905.zip) |  1.0G |  7.08 (librispeech test-clean)  8.25 (tedlium) | Wideband model for dictation from [Kaldi-active-grammar](https://github.com/daanzu/kaldi-active-grammar) project | AGPL |
| [vosk-model-en-us-daanzu-20200905-lgraph](https://alphacephei.com/vosk/models/vosk-model-en-us-daanzu-20200905-lgraph.zip) |  129M | 8.20 (librispeech test-clean) 9.28 (tedlium) | Wideband model for dictation from [Kaldi-active-grammar](https://github.com/daanzu/kaldi-active-grammar) project with configurable graph | AGPL |
| [vosk-model-en-us-librispeech-0.2](https://alphacephei.com/vosk/models/vosk-model-en-us-librispeech-0.2.zip) | 845M | TBD | Repackaged Librispeech model from [Kaldi](http://kaldi-asr.org/models/m13). Not very accurate, mainly for research | Apache 2.0 |
| [vosk-model-small-en-us-zamia-0.5](http://alphacephei.com/vosk/models/vosk-model-small-en-us-zamia-0.5.zip) |  49M  | 11.55 (librispeech test-clean) 12.64 (tedlium) | Repackaged Zamia model f_250, mainly for research | LGPL-3.0 |
| **Indian English**                                                                                        |       |            |            |       |
| [vosk-model-en-in-0.4](https://alphacephei.com/vosk/models/vosk-model-en-in-0.4.zip)                      |  370M | TBD | Generic Indian English model for telecom and broadcast | Apache 2.0 |
| [vosk-model-small-en-in-0.4](http://alphacephei.com/vosk/models/vosk-model-small-en-in-0.4.zip)           |  36M  | TBD | Lightweight Indian English model for mobile applications | Apache 2.0 |
| **Chinese**                                                                                               |       |            |     |  |
| [vosk-model-cn-0.1.zip](https://alphacephei.com/vosk/models/vosk-model-cn-0.1.zip)                        |  195M | TBD | Big narrowband Chinese model for server processing | Apache 2.0 |
| [vosk-model-small-cn-0.3](https://alphacephei.com/vosk/models/vosk-model-small-cn-0.3.zip)                |  32M  | TBD | Lightweight wideband model for Android and RPi | Apache 2.0 |
| **Russian**                                                                                               |       |            |     |  |
| [vosk-model-ru-0.10.zip](https://alphacephei.com/vosk/models/vosk-model-ru-0.10.zip)                      |  2.5G | 5.71 (our audiobooks) 16.26 (open_stt audiobooks) 26.20 (public_youtube_700_val open_stt) 40.15 (asr_calls_2_val open_stt) | Big narrowband Russian model for server processing | Apache 2.0 |
| [vosk-model-small-ru-0.15](https://alphacephei.com/vosk/models/vosk-model-small-ru-0.15.zip)              |  43M  | 22.21 (openstt audiobooks) 30.89 (openstt youtube) 28.65 (sova devices) | Lightweight wideband model for Android/iOS and RPi | Apache 2.0 |
| **French**                                                                                                |       |            |     |  |
| [vosk-model-small-fr-pguyot-0.3](https://alphacephei.com/vosk/models/vosk-model-small-fr-pguyot-0.3.zip)  |  39M  | TBD | Lightweight wideband model for Android and RPi trained by [Paul Guyot](https://github.com/pguyot/zamia-speech/releases) | CC-BY-NC-SA 4.0 |
| [fr-pguyot-zamia-20191016-tdnn_f](https://github.com/pguyot/zamia-speech/releases/download/20190930/kaldi-generic-fr-tdnn_f-r20191016.tar.xz) | 282M | 27.98 (cv test) | Bigger more accurate model by [Paul Guyot](https://github.com/pguyot/zamia-speech/releases) | CC-BY-NC-SA 4.0 |
| [vosk-model-fr-0.6-linto-2.2.0](https://alphacephei.com/vosk/models/vosk-model-fr-0.6-linto-2.2.0.zip)    |  1.5G  | 15.94 (cv test) 0.4xRT | Big accurate model for wideband transcription [LINTO](https://doc.linto.ai/#/services/linstt). Last version: bigger, slower | AGPL |
| [vosk-model-fr-0.6-linto-2.0.0](https://alphacephei.com/vosk/models/vosk-model-fr-0.6-linto-2.0.0.zip)    |  1.4G  | 16.25 (cv test) 0.2xRT | Big accurate model for wideband transcription [LINTO](https://doc.linto.ai/#/services/linstt) | AGPL |
| **German**                                                                                                |       |            |     |  |
| [vosk-model-de-0.6](https://alphacephei.com/vosk/models/vosk-model-de-0.6.zip)                            |  1.2G | 9.31 (Tuda-de test), 26.26 (podcast) | Big narrowband German model for telephony and server | Apache 2.0 |
| [vosk-model-small-de-zamia-0.3](https://alphacephei.com/vosk/models/vosk-model-small-de-zamia-0.3.zip)    |  49M  | 14.81 (Tuda-de test, 37.46 (podcast) | Zamia f_250 small model repackaged (not recommended) | LGPL-3.0   |
| [vosk-model-small-de-0.15](https://alphacephei.com/vosk/models/vosk-model-small-de-0.15.zip)              |  45M  | 13.75 (Tuda-de test), 30.67 (podcast) | Lightweight wideband model for Android and RPi | Apache 2.0 |
| **Spanish**                                                                                               |       |            |     |  |
| [vosk-model-small-es-0.3](https://alphacephei.com/vosk/models/vosk-model-small-es-0.3.zip)                |  33M  | TBD | Lightweight wideband model for Android and RPi | Apache 2.0 |
| **Portuguese/Brazilian Portuguese**                                                                       |       |            |     |  |
| [vosk-model-small-pt-0.3](https://alphacephei.com/vosk/models/vosk-model-small-pt-0.3.zip)                |  31M  | TBD | Lightweight wideband model for Android and RPi | Apache 2.0 |
| **Greek**                                                                                                 |       |            |     |  |
| [vosk-model-el-gr-0.7.zip](https://alphacephei.com/vosk/models/vosk-model-el-gr-0.7.zip)                  |  1.1G | TBD | Big narrowband Greek model for server processing, not extremely accurate though | Apache 2.0 |
| **Turkish**                                                                                               |       |            |     |  |
| [vosk-model-small-tr-0.3](https://alphacephei.com/vosk/models/vosk-model-small-tr-0.3.zip)                |  35M  | TBD | Lightweight wideband model for Android and RPi | Apache 2.0 |
| **Vietnamese**                                                                                            |       |            |     |  |
| [vosk-model-small-vn-0.3](https://alphacephei.com/vosk/models/vosk-model-small-vn-0.3.zip)                |  32M  | TBD | Lightweight wideband model for Android and RPi | Apache 2.0 |
| **Italian**                                                                                               |       |            |     |  |
| [vosk-model-small-it-0.4](https://alphacephei.com/vosk/models/vosk-model-small-it-0.4.zip)                |  32M  | TBD | Lightweight wideband model for Android and RPi | Apache 2.0 |
| **Dutch**                                                                                                 |       |            |     |  |
| [vosk-model-nl-spraakherkenning-0.6.zip](https://alphacephei.com/vosk/models/vosk-model-nl-spraakherkenning-0.6.zip) |  860M  | TBD | Medium Dutch model from [Kaldi_NL](https://github.com/opensource-spraakherkenning-nl/Kaldi_NL) | Apache 2.0 |
| [vosk-model-nl-spraakherkenning-0.6-lgraph.zip](https://alphacephei.com/vosk/models/vosk-model-nl-spraakherkenning-0.6-lgraph.zip) |  100M  | TBD | Smaller model with dynamic graph | Apache 2.0 |
| **Catalan**                                                                                               |       |            |     |  |
| [vosk-model-small-ca-0.4](https://alphacephei.com/vosk/models/vosk-model-small-ca-0.4.zip)                |  42M  | TBD | Lightweight wideband model for Android and RPi for Catalan | Apache 2.0 |
| **Arabic**                                                                                                |       |            |     |  |
| [vosk-model-ar-mgb2-0.4](https://alphacephei.com/vosk/models/vosk-model-ar-mgb2-0.4.zip)                  |  318M | 16.40 (MGB-2 dev set) | Repackaged Arabic model trained on MGB2 dataset from [Kaldi](https://kaldi-asr.org/models/m9) | Apache 2.0 |
| **Farsi**                                                                                                 |       |            |     |  |
| [vosk-model-small-fa-0.4](https://alphacephei.com/vosk/models/vosk-model-small-fa-0.4.zip)                |  47M  | TBD | Lightweight wideband model for Android and RPi for Farsi (Persian) | Apache 2.0 |
| [vosk-model-fa-0.5](https://alphacephei.com/vosk/models/vosk-model-fa-0.5.zip)                            |  1G   | TBD | Model with large vocabulary, not yet accurate but better than before (Persian) | Apache 2.0 |
| [vosk-model-small-fa-0.5](https://alphacephei.com/vosk/models/vosk-model-small-fa-0.5.zip)                |  60M  | TBD | Bigger small model for desktop application (Persian) | Apache 2.0 |
| **Filipino**                                                                                                 |       |            |     |  |
| [vosk-model-tl-ph-generic-0.6.zip](https://alphacephei.com/vosk/models/vosk-model-tl-ph-generic-0.6.zip)  |  320M  | TBD | Medium wideband model for Filipino (Tagalog) by [feddybear](https://github.com/feddybear/flipside_ph) | CC-BY-NC-SA 4.0 |
| **Ukrainian**                                                                                             |       |            |     |  |
| [vosk-model-small-uk-v3-nano](https://alphacephei.com/vosk/models/vosk-model-small-uk-v3-nano.zip)        |  73M  | TBD | Nano model from [Speech Recognition for Ukrainian](https://github.com/egorsmkv/speech-recognition-uk) | Apache 2.0 |
| [vosk-model-small-uk-v3-small](https://alphacephei.com/vosk/models/vosk-model-small-uk-v3-small.zip)      | 133M  | TBD | Small model from [Speech Recognition for Ukrainian](https://github.com/egorsmkv/speech-recognition-uk) | Apache 2.0 |
| [vosk-model-uk-v3](https://alphacephei.com/vosk/models/vosk-model-uk-v3.zip)                              |  343M | TBD | Bigger model from [Speech Recognition for Ukrainian](https://github.com/egorsmkv/speech-recognition-uk) | Apache 2.0 |
| **Kazakh**                                                                                                |       |            |     |  |
| [vosk-model-small-kz-0.15](https://alphacephei.com/vosk/models/vosk-model-small-kz-0.15.zip)              |  42M  | 9.60(dev) 8.32(test) | Small mobile model from [SAIDA_Kazakh](https://github.com/IS2AI/ISSAI_SAIDA_Kazakh_ASR)| Apache 2.0 |
| [vosk-model-kz-0.15](https://alphacephei.com/vosk/models/vosk-model-kz-0.15.zip)                          |  378M | 8.06(dev) 6.81(test) | Bigger wideband model [SAIDA_Kazakh](https://github.com/IS2AI/ISSAI_SAIDA_Kazakh_ASR)| Apache 2.0 |
| **Speaker identification model**                                                                          |       |            |     |  |
| [vosk-model-spk-0.4](https://alphacephei.com/vosk/models/vosk-model-spk-0.4.zip)                          |  13M  | TBD | Model for speaker identification, should work for all languages | Apache 2.0 |


## Other models

Other places where you can check for models which might be compatible:

  * <http://kaldi-asr.org/models.html> - variety of models from Kaldi - librispeech, aspire, chinese models
  * <https://github.com/daanzu/kaldi-active-grammar/blob/master/docs/models.md> - Big dictation models for English
  * <https://github.com/uhh-lt/vosk-model-tuda-de> - German models
  * <https://github.com/german-asr/kaldi-german> - Another German project
  * <http://zamia-speech.org/asr/> - German and English model from Zamia
  * <https://github.com/pguyot/zamia-speech/releases> - French models for Zamia
  * <https://github.com/opensource-spraakherkenning-nl/Kaldi_NL> - Dutch model
  * <https://montreal-forced-aligner.readthedocs.io/en/latest/pretrained_models.html> (GMM models, not compatible but might be still useful)
  * <https://github.com/goodatlas/zeroth> - Korean Kaldi (just a recipe and data to train)
  * <https://github.com/undertheseanlp/automatic_speech_recognition> - Vietnamese Kaldi project
  * <https://doc.linto.ai/#/services/linstt> - LINTO project with French and English models
  * <https://community.rhasspy.org/> - Rhasspy (some Kaldi models for Czech, probably even more)
  * <https://github.com/feddybear/flipside_ph> - Filipino model project by Federico Ang
  * <https://github.com/alumae/kiirkirjutaja> - Estonian Speech Recognition project with Vosk models
  * <https://github.com/falabrasil/kaldi-br> - Portuguese models from FalaBrasil project
  * <https://github.com/egorsmkv/speech-recognition-uk> - Ukrainian ASR project with Vosk models

## Training your own model

You can train your model with Kaldi toolkit. The training is pretty
standard - you need tdnn nnet3 model with i-vectors. You can check
mini_librispeech recipe for details. Some notes on training:

  * For smaller mobile models watch number of parameters
  * Train the model without pitch. It might be helpful for small amount of data, but for large database it doesn't give the advantage
but complicates the processing and increases response time.
  * Train ivector of dim 30 instead of standard 100 to save memory of mobile models.
  * Latest mini_librispeech uses online cmvn which we do not support yet. Use [this script](https://github.com/kaldi-asr/kaldi/blob/master/egs/mini_librispeech/s5/local/chain/tuning/run_tdnn_1j.sh) to train nnet3 model.

PLEASE NOTE THAT THE SIMPLE GMM MODEL YOU TRAIN WITH **"KALDI FOR
DUMMIES"** TUTORIAL **DOES NOT WORK** WITH VOSK. YOU NEED TO RUN
MINI-LIBRISPEECH FROM START TO END, INCLUDING **CHAIN MODEL TRAINING**.
You also need CUDA GPU to train. If you do not have a GPU, try to run
Kaldi on Collab.

## Model structure

Once you trained the model arrange the files according to the following layout (see en-us-aspire for details):

  * `am/final.mdl` - acoustic model
  * `conf/mfcc.conf` - mfcc config file. Make sure you take mfcc_hires.conf version if you are using hires model (most external ones)
  * `conf/model.conf` - provide default decoding beams and silence phones. you have to create this file yourself, it is not present in kaldi model
  * `conf/pitch.conf` - optional file to create feature pipeline with pitch features. Might be missing if model doesn't use pitch
  * `ivector/final.dubm` - take ivector files from ivector extractor (optional folder if the model is trained with ivectors)
  * `ivector/final.ie`
  * `ivector/final.mat`
  * `ivector/splice.conf`
  * `ivector/global_cmvn.stats`
  * `ivector/online_cmvn.conf`
  * `graph/phones/word_boundary.int` - from the graph
  * `graph/HCLG.fst` - this is the decoding graph, if you are not using lookahead
  * `graph/HCLr.fst` - use Gr.fst and HCLr.fst instead of one big HCLG.fst if you want to run rescoring
  * `graph/Gr.fst`
  * `graph/phones.txt` - from the graph
  * `graph/words.txt` - from the graph
  * `rescore/G.carpa` - carpa rescoring is optional but helpful in big models. Usually located inside data/lang_test_rescore
  * `rescore/G.fst` - also optional if you want to use rescoring, also used for interpolation with RNNLM
  * `rnnlm/feat_embedding.final.mat` - RNNLM embedding for rescoring. Optional if you have it.
  * `rnnlm/special_symbol_opts.conf` - RNNLM model options
  * `rnnlm/final.raw` - RNNLM model
  * `rnnlm/word_feats.txt` - RNNLM model word feats
