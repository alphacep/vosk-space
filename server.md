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

or for Chinese. The model is based on Kaldi multi-cn recipe, thanks to [Xingyu Na](https://github.com/naxingyu).

```
docker run -d -p 2700:2700 alphacep/kaldi-cn:latest
```

or for Russian

```
docker run -d -p 2700:2700 alphacep/kaldi-ru:latest
```

or for German

```
docker run -d -p 2700:2700 alphacep/kaldi-de:latest
```

or for Indian English

```
docker run -d -p 2700:2700 alphacep/kaldi-en-in:latest
```

Run

```
git clone https://github.com/alphacep/vosk-server
cd vosk-server/websocket
./test.py test.wav
```

You can try with any wav file which has proper format - 8khz 16bit mono PCM.
Other formats has to be converted before decoding.

## Troubleshooting

Some servers use huge carpa models for best accuracy. To load them in memory you need about 8Gb of memory or even more. Make sure you have enough memory on your server.

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
