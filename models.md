---
layout: default
title: VOSK Models
permalink: /models
---

# Models

We have two types of models - big and small, small models are ideal for
some limited task on mobile applications. They can run on smartphones,
Raspberry Pi's. They are also recommended for desktop applications. Small
model typically is around 50Mb in size and requires about 300Mb of memory
in runtime. Big models are for the high-accuracy transcription on the
server. Big models require up to 16Gb in memory since they apply advanced
AI algorithms. Ideally you run them on some high-end servers like i7 or
latest AMD Ryzen. On AWS you can take a look on c5a machines and similar
machines in other clouds.

Most small model allow dynamic vocabulary reconfiguration. Big models are
static the vocabulary can not be modified in runtime.

## Model list

This is the list of models compatible with Vosk-API.

To add a new model here create an issue on Github.

{:class="table table-bordered"}
| Model                                                                                                     | Size  | Word error rate/Speed | Notes | License    |
|-----------------------------------------------------------------------------------------------------------|-------|------------|-------|------------|
| **English**                                                                                               |       |            |       |            |
| [vosk-model-small-en-us-0.15](https://alphacephei.com/vosk/models/vosk-model-small-en-us-0.15.zip)         |  40M  | 9.85 (librispeech test-clean) 10.38 (tedlium) | Lightweight wideband model for Android and RPi | Apache 2.0 |
| [vosk-model-en-us-0.22](https://alphacephei.com/vosk/models/vosk-model-en-us-0.22.zip)                     |  1.8G | 5.69 (librispeech test-clean) 6.05 (tedlium) 29.78(callcenter) | Accurate generic US English model | Apache 2.0 |
| [vosk-model-en-us-0.22-lgraph](https://alphacephei.com/vosk/models/vosk-model-en-us-0.22-lgraph.zip)       |  128M | 7.82 (librispeech) 8.20 (tedlium) | Big US English model with dynamic graph | Apache 2.0 |
| **English Other**                                                                                         |       | **Older Models**   |       |            |
| [vosk-model-en-us-daanzu-20200905](https://alphacephei.com/vosk/models/vosk-model-en-us-daanzu-20200905.zip) |  1.0G |  7.08 (librispeech test-clean)  8.25 (tedlium) | Wideband model for dictation from [Kaldi-active-grammar](https://github.com/daanzu/kaldi-active-grammar) project | AGPL |
| [vosk-model-en-us-daanzu-20200905-lgraph](https://alphacephei.com/vosk/models/vosk-model-en-us-daanzu-20200905-lgraph.zip) |  129M | 8.20 (librispeech test-clean) 9.28 (tedlium) | Wideband model for dictation from [Kaldi-active-grammar](https://github.com/daanzu/kaldi-active-grammar) project with configurable graph | AGPL |
| [vosk-model-en-us-librispeech-0.2](https://alphacephei.com/vosk/models/vosk-model-en-us-librispeech-0.2.zip) | 845M | TBD | Repackaged Librispeech model from [Kaldi](https://kaldi-asr.org/models/m13), not very accurate | Apache 2.0 |
| [vosk-model-small-en-us-zamia-0.5](https://alphacephei.com/vosk/models/vosk-model-small-en-us-zamia-0.5.zip) |  49M  | 11.55 (librispeech test-clean) 12.64 (tedlium) | Repackaged Zamia model f_250, mainly for research | LGPL-3.0 |
| [vosk-model-en-us-aspire-0.2](https://alphacephei.com/vosk/models/vosk-model-en-us-aspire-0.2.zip)        |  1.4G | 13.64 (librispeech test-clean) 12.89 (tedlium) 33.82(callcenter) | Kaldi original ASPIRE model, not very accurate | Apache 2.0 |
| [vosk-model-en-us-0.21](https://alphacephei.com/vosk/models/vosk-model-en-us-0.21.zip)                     |  1.6G | 5.43 (librispeech test-clean) 6.42 (tedlium) 40.63(callcenter) | Wideband model previous generation | Apache 2.0 |
| **Indian English**                                                                                        |       |            |            |       |
| [vosk-model-en-in-0.5](https://alphacephei.com/vosk/models/vosk-model-en-in-0.5.zip)                      |  1G | 36.12 (NPTEL Pure) | Generic Indian English model for telecom and broadcast | Apache 2.0 |
| [vosk-model-small-en-in-0.4](https://alphacephei.com/vosk/models/vosk-model-small-en-in-0.4.zip)           |  36M  | 49.05 (NPTEL Pure) | Lightweight Indian English model for mobile applications | Apache 2.0 |
| **Chinese**                                                                                               |       |            |     |  |
| [vosk-model-small-cn-0.22](https://alphacephei.com/vosk/models/vosk-model-small-cn-0.22.zip)                |  42M  | 23.54 (SpeechIO-02) 38.29 (SpeechIO-06) 17.15 (THCHS) | Lightweight model for Android and RPi | Apache 2.0 |
| [vosk-model-cn-0.22](https://alphacephei.com/vosk/models/vosk-model-cn-0.22.zip)                        |  1.3G | 13.98 (SpeechIO-02) 27.30 (SpeechIO-06) 7.43 (THCHS) | Big generic Chinese model for server processing | Apache 2.0 |
| **Chinese Other**                                                                                               |       |            |     |  |
| [vosk-model-cn-kaldi-multicn-0.15](https://alphacephei.com/vosk/models/vosk-model-cn-kaldi-multicn-0.15.zip)  |  1.5G | 17.44 (SpeechIO-02) 9.56 (THCHS) | Original Wideband Kaldi multi-cn model from [Kaldi](https://kaldi-asr.org/models/m11) with Vosk LM | Apache 2.0 |
| **Russian**                                                                                               |       |            |     |  |
| [vosk-model-ru-0.22](https://alphacephei.com/vosk/models/vosk-model-ru-0.22.zip)                          |  1.5G | 5.74 (our audiobooks) 13.35 (open_stt audiobooks) 20.73 (open_stt youtube) 37.38 (openstt calls) 8.65 (golos crowd) 19.71 (sova devices) | Big mixed band Russian model for server processing | Apache 2.0 |
| [vosk-model-small-ru-0.22](https://alphacephei.com/vosk/models/vosk-model-small-ru-0.22.zip)              |  45M  | 22.71 (openstt audiobooks) 31.97 (openstt youtube) 29.89 (sova devices) 11.79 (golos crowd) | Lightweight wideband model for Android/iOS and RPi | Apache 2.0 |
| **Russian Other**                                                                                               |       |            |     |  |
| [vosk-model-ru-0.10](https://alphacephei.com/vosk/models/vosk-model-ru-0.10.zip)                      |  2.5G | 5.71 (our audiobooks) 16.26 (open_stt audiobooks) 26.20 (public_youtube_700_val open_stt) 40.15 (asr_calls_2_val open_stt) | Big narrowband Russian model for server processing | Apache 2.0 |
| **French**                                                                                                |       |            |     |  |
| [vosk-model-small-fr-0.22](https://alphacephei.com/vosk/models/vosk-model-small-fr-0.22.zip)              |  41M  | 23.95 (cv test) 19.30 (mtedx) 27.25 (podcast) | Lightweight wideband model for Android/iOS and RPi | Apache 2.0 |
| [vosk-model-fr-0.22](https://alphacephei.com/vosk/models/vosk-model-fr-0.22.zip)                          |  1.4G  | 14.72 (cv test) 11.64 (mls) 13.10 (mtedx) 21.61 (podcast) 13.22 (voxpopuli) | Big accurate model for servers | Apache 2.0 |
| **French Other**                                                                                                |       |            |     |  |
| [vosk-model-small-fr-pguyot-0.3](https://alphacephei.com/vosk/models/vosk-model-small-fr-pguyot-0.3.zip)  |  39M  | 37.04 (cv test) 28.72 (mtedx) 37.46 (podcast) | Lightweight wideband model for Android and RPi trained by [Paul Guyot](https://github.com/pguyot/zamia-speech/releases) | CC-BY-NC-SA 4.0 |
| [vosk-model-fr-0.6-linto-2.2.0](https://alphacephei.com/vosk/models/vosk-model-fr-0.6-linto-2.2.0.zip)    |  1.5G  | 16.19 (cv test) 16.44 (mtedx) 23.77 (podcast) 0.4xRT | Model from [LINTO](https://doc.linto.ai/#/services/linstt) project | AGPL |
| **German**                                                                                                |       |            |     |  |
| [vosk-model-de-0.21](https://alphacephei.com/vosk/models/vosk-model-de-0.21.zip)                          |  1.9G | 9.30 (Tuda-de test), 24.10 (podcast) 11.99 (cv-test) | Big narrowband German model for telephony and server | Apache 2.0 |
| [vosk-model-small-de-zamia-0.3](https://alphacephei.com/vosk/models/vosk-model-small-de-zamia-0.3.zip)    |  49M  | 14.81 (Tuda-de test, 37.46 (podcast) | Zamia f_250 small model repackaged (not recommended) | LGPL-3.0   |
| [vosk-model-small-de-0.15](https://alphacephei.com/vosk/models/vosk-model-small-de-0.15.zip)              |  45M  | 13.75 (Tuda-de test), 30.67 (podcast) | Lightweight wideband model for Android and RPi | Apache 2.0 |
| **Spanish**                                                                                               |       |            |     |  |
| [vosk-model-small-es-0.22](https://alphacephei.com/vosk/models/vosk-model-small-es-0.22.zip)              |  39M  | 18.51 (cv test) 20.39 (mtedx test) | Lightweight wideband model for Android and RPi | Apache 2.0 |
| **Portuguese/Brazilian Portuguese**                                                                       |       |            |     |  |
| [vosk-model-small-pt-0.3](https://alphacephei.com/vosk/models/vosk-model-small-pt-0.3.zip)                |  31M  | 68.92 (coraa dev) 32.60 (cv test) | Lightweight wideband model for Android and RPi | Apache 2.0 |
| [vosk-model-pt-fb-v0.1.1-20220516_2113](https://alphacephei.com/vosk/models/vosk-model-pt-fb-v0.1.1-20220516_2113.zip)  |  1.6G | 54.34 (coraa dev) 27.70 (cv test) | Big model from [FalaBrazil](https://gitlab.com/fb-resources/kaldi-br) | GPLv3.0 |
| **Greek**                                                                                                 |       |            |     |  |
| [vosk-model-el-gr-0.7](https://alphacephei.com/vosk/models/vosk-model-el-gr-0.7.zip)                  |  1.1G | TBD | Big narrowband Greek model for server processing, not extremely accurate though | Apache 2.0 |
| **Turkish**                                                                                               |       |            |     |  |
| [vosk-model-small-tr-0.3](https://alphacephei.com/vosk/models/vosk-model-small-tr-0.3.zip)                |  35M  | TBD | Lightweight wideband model for Android and RPi | Apache 2.0 |
| **Vietnamese**                                                                                            |       |            |     |  |
| [vosk-model-small-vn-0.3](https://alphacephei.com/vosk/models/vosk-model-small-vn-0.3.zip)                |  32M  | TBD | Lightweight wideband model for Android and RPi | Apache 2.0 |
| **Italian**                                                                                               |       |            |     |  |
| [vosk-model-small-it-0.4](https://alphacephei.com/vosk/models/vosk-model-small-it-0.4.zip)                |  32M  | TBD | Lightweight wideband model for Android and RPi | Apache 2.0 |
| **Dutch**                                                                                                 |       |            |     |  |
| [vosk-model-small-nl-0.22](https://alphacephei.com/vosk/models/vosk-model-small-nl-0.22.zip)              |  39M  | 22.45 (CV Test) 26.80 (TV) 25.84 (MLS) 24.09 (Voxpopuli) | Lightweight model for Dutch | Apache 2.0 |
| **Dutch Other**                                                                                                 |       |            |     |  |
| [vosk-model-nl-spraakherkenning-0.6](https://alphacephei.com/vosk/models/vosk-model-nl-spraakherkenning-0.6.zip) |  860M  | 20.40 (CV Test) 32.64 (TV) 17.73 (MLS) 19.96 (Voxpopuli)  | Medium Dutch model from [Kaldi_NL](https://github.com/opensource-spraakherkenning-nl/Kaldi_NL) | CC-BY-NC-SA |
| [vosk-model-nl-spraakherkenning-0.6-lgraph](https://alphacephei.com/vosk/models/vosk-model-nl-spraakherkenning-0.6-lgraph.zip) |  100M  | 22.82 (CV Test) 34.01 (TV) 18.81 (MLS) 21.01 (Voxpopuli) | Smaller model with dynamic graph | CC-BY-NC-SA  |
| **Catalan**                                                                                               |       |            |     |  |
| [vosk-model-small-ca-0.4](https://alphacephei.com/vosk/models/vosk-model-small-ca-0.4.zip)                |  42M  | TBD | Lightweight wideband model for Android and RPi for Catalan | Apache 2.0 |
| **Arabic**                                                                                                |       |            |     |  |
| [vosk-model-ar-mgb2-0.4](https://alphacephei.com/vosk/models/vosk-model-ar-mgb2-0.4.zip)                  |  318M | 16.40 (MGB-2 dev set) | Repackaged Arabic model trained on MGB2 dataset from [Kaldi](https://kaldi-asr.org/models/m9) | Apache 2.0 |
| **Farsi**                                                                                                 |       |            |     |  |
| [vosk-model-small-fa-0.4](https://alphacephei.com/vosk/models/vosk-model-small-fa-0.4.zip)                |  47M  | TBD | Lightweight wideband model for Android and RPi for Farsi (Persian) | Apache 2.0 |
| [vosk-model-fa-0.5](https://alphacephei.com/vosk/models/vosk-model-fa-0.5.zip)                            |  1G   | TBD | Model with large vocabulary, not yet accurate but better than before (Persian) | Apache 2.0 |
| [vosk-model-small-fa-0.5](https://alphacephei.com/vosk/models/vosk-model-small-fa-0.5.zip)                |  60M  | TBD | Bigger small model for desktop application (Persian) | Apache 2.0 |
| **Filipino**                                                                                              |       |            |     |  |
| [vosk-model-tl-ph-generic-0.6](https://alphacephei.com/vosk/models/vosk-model-tl-ph-generic-0.6.zip)      |  320M  | TBD | Medium wideband model for Filipino (Tagalog) by [feddybear](https://github.com/feddybear/flipside_ph) | CC-BY-NC-SA 4.0 |
| **Ukrainian**                                                                                             |       |            |     |  |
| [vosk-model-small-uk-v3-nano](https://alphacephei.com/vosk/models/vosk-model-small-uk-v3-nano.zip)        |  73M  | TBD | Nano model from [Speech Recognition for Ukrainian](https://github.com/egorsmkv/speech-recognition-uk) | Apache 2.0 |
| [vosk-model-small-uk-v3-small](https://alphacephei.com/vosk/models/vosk-model-small-uk-v3-small.zip)      | 133M  | TBD | Small model from [Speech Recognition for Ukrainian](https://github.com/egorsmkv/speech-recognition-uk) | Apache 2.0 |
| [vosk-model-uk-v3](https://alphacephei.com/vosk/models/vosk-model-uk-v3.zip)                              |  343M | TBD | Bigger model from [Speech Recognition for Ukrainian](https://github.com/egorsmkv/speech-recognition-uk) | Apache 2.0 |
| [vosk-model-uk-v3-lgraph](https://alphacephei.com/vosk/models/vosk-model-uk-v3-lgraph.zip)                |  325M | TBD | Big dynamic model from [Speech Recognition for Ukrainian](https://github.com/egorsmkv/speech-recognition-uk) | Apache 2.0 |
| **Kazakh**                                                                                                |       |            |     |  |
| [vosk-model-small-kz-0.15](https://alphacephei.com/vosk/models/vosk-model-small-kz-0.15.zip)              |  42M  | 9.60(dev) 8.32(test) | Small mobile model from [SAIDA_Kazakh](https://github.com/IS2AI/ISSAI_SAIDA_Kazakh_ASR)| Apache 2.0 |
| [vosk-model-kz-0.15](https://alphacephei.com/vosk/models/vosk-model-kz-0.15.zip)                          |  378M | 8.06(dev) 6.81(test) | Bigger wideband model [SAIDA_Kazakh](https://github.com/IS2AI/ISSAI_SAIDA_Kazakh_ASR)| Apache 2.0 |
| **Swedish**                                                                                               |       |            |     |  |
| [vosk-model-small-sv-rhasspy-0.15](https://alphacephei.com/vosk/models/vosk-model-small-sv-rhasspy-0.15.zip)      |  289M | TBD | Repackaged model from [Rhasspy project](https://github.com/rhasspy/sv_kaldi-rhasspy) | MIT |
| **Japanese**                                                                                              |       |            |     |  |
| [vosk-model-small-ja-0.22](https://alphacephei.com/vosk/models/vosk-model-small-ja-0.22.zip)              |  48M | 9.52(csj CER) 17.07(ted10k CER) | Lightweight wideband model for Japanese | Apache 2.0 |
| **Esperanto**                                                                                             |       |            |     |  |
| [vosk-model-small-eo-0.22](https://alphacephei.com/vosk/models/vosk-model-small-eo-0.22.zip)              |  40M  | 8.28 (CV Test) | Lightweight wideband model for Esperanto | Apache 2.0 |
| **Hindi**                                                                                                 |       |            |     |  |
| [vosk-model-small-hi-0.22](https://alphacephei.com/vosk/models/vosk-model-small-hi-0.22.zip)              |  42M | 20.89 (IITM Challenge) 24.72 (MUCS Challenge) | Lightweight model for Hindi | Apache 2.0 |
| [vosk-model-hi-0.22](https://alphacephei.com/vosk/models/vosk-model-hi-0.22.zip)                          |  1.5Gb | 14.85 (CV Test) 14.83 (IITM Challenge) 13.11 (MUCS Challenge) | Big accurate model for servers | Apache 2.0 |
| **Czech**                                                                                                 |       |            |     |  |
| [vosk-model-small-cs-0.4-rhasspy](https://alphacephei.com/vosk/models/vosk-model-small-cs-0.4-rhasspy.zip)|  44M | 21.29 (CV Test) | Lightweight model for Czech from Rhasspy project | MIT |
| **Polish**                                                                                                 |       |            |     |  |
| [vosk-model-small-pl-0.22](https://alphacephei.com/vosk/models/vosk-model-small-pl-0.22.zip)              |  50.5M | 18.36 (CV Test) 16.88 (MLS Test) 11.55 (Voxpopuli Test)| Lightweight model for Polish for Android | Apache 2.0 |
| **Speaker identification model**                                                                          |       |            |     |  |
| [vosk-model-spk-0.4](https://alphacephei.com/vosk/models/vosk-model-spk-0.4.zip)                          |  13M  | TBD | Model for speaker identification, should work for all languages | Apache 2.0 |


## Punctuation models

For punctuation and case restoration we recommend the  models trained with <https://github.com/benob/recasepunc>

{:class="table table-bordered"}
| Model                                                                                                     | Size  | License    |
|-----------------------------------------------------------------------------------------------------------|-------|------------|
| **English**                                                                                               |       |            |
| [vosk-recasepunc-en-0.22](https://alphacephei.com/vosk/models/vosk-recasepunc-en-0.22.zip)                 |  1.6G | Apache 2.0 |
| **Russian**                                                                                               |       |            |
| [vosk-recasepunc-ru-0.22](https://alphacephei.com/vosk/models/vosk-recasepunc-ru-0.22.zip)                 |  1.6G | Apache 2.0 |
| **German**                                                                                                |       |            |
| [vosk-recasepunc-de-0.21](https://alphacephei.com/vosk/models/vosk-recasepunc-de-0.21.zip)                 |  1.1G | Apache 2.0 |

## Other models

Other places where you can check for models which might be compatible:

  * <https://kaldi-asr.org/models.html> - variety of models from Kaldi - librispeech, aspire, chinese models
  * <https://github.com/daanzu/kaldi-active-grammar/blob/master/docs/models.md> - Big dictation models for English
  * <https://github.com/uhh-lt/vosk-model-tuda-de> - German models
  * <https://github.com/german-asr/kaldi-german> - Another German project
  * <https://zamia-speech.org/asr/> - German and English model from Zamia
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
  * <https://github.com/Appen/UHV-OTS-Speech> - repository from Appen for Scalable Data Annotation Pipeline for High-Quality Large Speech Datasets Development
  * <https://github.com/vistec-AI/commonvoice-th> - Thai models trained on CommonVoice

## Training your own model

You can train your model with Kaldi toolkit. The training is pretty
standard - you need tdnn nnet3 model with i-vectors. You can check Vosk recipe for details:

<https://github.com/alphacep/vosk-api/tree/master/training>

  * For smaller mobile models watch the number of parameters
  * Train the model without pitch. It might be helpful for small amount of data, but for large database it doesn't give the advantage
but complicates the processing and increases response time.
  * Train ivector of dim 40 instead of standard 100 to save memory of mobile models.
  * Many Kaldi recipes are overcomplicated and do many unnecessary steps
  * PLEASE NOTE THAT THE SIMPLE GMM MODEL YOU TRAIN WITH **"KALDI FOR DUMMIES"** TUTORIAL **DOES NOT WORK** WITH VOSK. YOU NEED TO RUN VOSK RECIPE FROM START TO END, INCLUDING **CHAIN MODEL TRAINING**. You also need CUDA GPU to train. If you do not have a GPU, try to run Kaldi on Google Colab.

## Model structure

Once you trained the model arrange the files according to the following layout (see en-us-aspire for details):

  * `am/final.mdl` - acoustic model
  * `am/global_cmvn.stats` - required for online-cmvn models, if present enables online cmvn on features.
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
