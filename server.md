---
layout: default
title: Websocket, gRPC, MQTT and WebRTC servers for VOSK
permalink: /server
---

[Vosk Server Github Project](https://github.com/alphacep/vosk-server)

A very simple server based on [Vosk-API](https://github.com/alphacep/vosk-api).

There are four implementations for different protocol - websocket, grpc, mqtt, webrtc.

## Usage

Start the server

```
docker run -d -p 2700:2700 alphacep/kaldi-en:latest
```

There are kaldi-en, kaldi-cn, kaldi-ru, kaldi-fr, kaldi-de and other images on [Docker Hub](https://hub.docker.com/u/alphacep).

You can also run the docker with your own model if you want to replace the default model by
binding your local model folder to the model folder inside the docker. It will even work
for a different language.

```
docker run -d -p 2700:2700 -v /opt/model:/opt/vosk-model-en/model alphacep/kaldi-en:latest
```

To test the server run the example script

```
git clone https://github.com/alphacep/vosk-server
cd vosk-server/websocket
./test.py test.wav
```

You can try with any wav file which has proper format - 16bit mono PCM.
Other formats has to be converted before decoding. See also test_ffmpeg.py.

## Troubleshooting

Some servers use huge carpa models for best accuracy. To load them in memory you need about 16Gb of memory or even more. Make sure you have enough memory on your server.

In case of problems try to run server manually from docker prompt and see what happens:

```
$ sudo docker run -it -p 2700:2700 alphacep/kaldi-en:latest /bin/bash
root@a9e0db45a54b:/opt/vosk-server/websocket# python3 ./asr_server.py /opt/vosk-model-en/model
LOG ([5.5.643~1-7e185]:ConfigureV2():src/model.cc:138) Decoding params beam=13 max-active=7000 lattice-beam=6
...
```

## Testing with microphone

You would need to install the sounddevice pip package:

```
pip3 install sounddevice
```

To test with a microphone, run

```
./test_microphone.py -u ws://localhost:2700
```

The recognized data will be printed on stdout.

## Other programming languages

Check other examples (Asterisk-EAGI, php, java, node, c#) in client-samples folder in this repository.
