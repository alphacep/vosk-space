---
layout: default
title: Offline speech recognition on Android with VOSK
permalink: /android
---

## About

This demo implements offline speech recognition and speaker identification for mobile applications using Kaldi and Vosk libraries.

[Vosk Demo on Android Github Project](https://github.com/alphacep/vosk-android-demo)

## Usage

Simply import the project into Android Studio and run. It will listen for the audio and dump the transcription.

To use this library in your application simply modify the demo according to your needs - add kaldi-android aar
to dependencies, update the model and modify java UI code according to your needs.

## Development

This is just a demo project, the main setup to compile vosk-android
library AAR is available at [vosk-api](http://github.com/alphacep/vosk-api). Check
compilation instructions there as well as development plans.

## Languages

Models for different languages (English, Chinese, Russian) are available
in [Models](models) section. To use the model unpack it into [assets](https://github.com/alphacep/vosk-android-demo/tree/master/models/src/main/assets/model-en-us) and
update the code to rebuild the UUID file in gradle file. More languages gonna be ready
soon.

## Updating grammar and language model

To run on android model has to be sufficiently small, we recommend to
check model sizes in the demo to figure out what should be the size of
the model. If you want to update the grammar or the acoustic model, check
[vosk-api documentation](https://github.com/alphacep/vosk-api/blob/master/doc/adapation.md).

## Nativescript

You can also use Vosk speech recognition with JS from Nativescript. See for details:
<https://github.com/alphacep/nativescript-vosk>
