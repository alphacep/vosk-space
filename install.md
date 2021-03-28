---
layout: default
title: Vosk Installation
permalink: /install
---

## Android build

```sh
cd android
gradle build
```

Please note that medium blog post about 64-bit is not relevant anymore,
the script builds x86, arm64 and armv7 libraries automatically without
any modifications.

For an example Android application using the Vosk-API check the <https://github.com/alphacep/vosk-android-demo> project.

## iOS build

Available on request. Drop as a mail at [contact@alphacephei.com](mailto:contact@alphacephei.com).

## Python installation from Pypi

The easiest way to install vosk api is with pip. You do not have to compile anything. 

We currently support the following platforms:

  * Linux on x86_64
  * Raspbian on Raspberry Pi
  * Linux on arm64
  * OSX
  * Windows

Make sure you have up-to-date pip and python3 versions:

  * Python version: 3.5-3.9 (Linux), 3.6-3.7 (ARM), 3.8-3.9 (OSX), 3.5-3.9 64-bit (Windows)
  * pip version: 19.0 and newer.

Uprade python and pip if needed. Then install vosk on Linux/Mac from pip:

```sh
pip3 install vosk
```

Please note that some platforms are not fully supported by pip, for example on arm64 you have install from released wheels:

```sh
pip3 install https://github.com/alphacep/vosk-api/releases/download/0.3.15/vosk-0.3.15-cp37-cp37m-linux_aarch64.whl
```

On Windows make sure you have 64-bit Python. We do not support 32-bit python yet. We might release 32 bit some time later.

If you have trouble installing, check the output of the following commands and provide it for reference:
```sh
python3 --version
pip3 --version
pip3 -v install vosk
```

## Websocket Server and GRPC server

We also provide a websocket server and grpc server which can be used in
telephony and other applications. With bigger models adapted for 8khz
audio it provides more accuracy.

The server is installable from docker and can be run with a single command:
```sh
docker run -d -p 2700:2700 alphacep/kaldi-en:latest
```

For details see <https://github.com/alphacep/vosk-server>

## Compilation from source

If you still want to build from scratch, you can compile Kaldi and Vosk
yourself. Please note that compilation is not straightforward and
includes several nuances. We recommend to follow our build process we
document in Docker files:

<https://github.com/alphacep/vosk-api/tree/master/travis>

For Windows and Raspberry Pi we recommend cross-build with mingw and corresponding
ARM toolchain. See docker files for details.

The outline of the build is [here](https://github.com/alphacep/vosk-api/blob/master/travis/Dockerfile.manylinux#L26).

#### Python module build

After you have built kaldi with openblas,clapack and openfst, you can buid python module:

```sh
git clone https://github.com/alphacep/vosk-api
cd vosk-api/src
KALDI_ROOT=<KALDI_ROOT> make
cd ../vosk-api/python
python3 setup.py install
```

## Usage examples

### Python

Clone the [vosk-api](https://github.com/alphacep/vosk-api) and run the following commands:

```
git clone https://github.com/alphacep/vosk-api
cd vosk-api/python/example
wget https://alphacephei.com/kaldi/models/vosk-model-small-en-us-0.15.zip
unzip vosk-model-small-en-us-0.15.zip
mv vosk-model-small-en-us-0.15 model
python3 ./test_simple.py test.wav
```

When using your own audio file make sure it has the correct format - PCM
16khz 16bit mono. Otherwise, if you have ffmpeg installed, you can use
`test_ffmpeg.py`, which does the conversion for you.

Find more examples such as using a microphone, decoding with a fixed
small vocabulary or speaker identification setup in the [python/example
subfolder](https://github.com/alphacep/vosk-api/tree/master/python/example)

For more info see this video:

<iframe width="560" height="315" src="https://www.youtube.com/embed/Itic1lFc4Gg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### Java

We distribute Vosk library in our own maven repository:

https://alphacephei.com/maven/

To plug the library simply add our maven repo and add the dependency:

```
repositories {
    mavenCentral()
    maven {
        url 'https://alphacephei.com/maven/'
    }
}

dependencies {
    implementation group: 'net.java.dev.jna', name: 'jna', version: '5.7.0'
    implementation group: 'com.alphacephei', name: 'vosk', version: '0.3.21+'
}
```

For example of a full demo project built with gradle see:

https://github.com/alphacep/vosk-api/tree/master/java/demo

The code samples are here:

https://github.com/alphacep/vosk-api/blob/master/java/demo/src/main/java/org/vosk/demo/DecoderDemo.java

We support Java 8+ on Linux, OSX and Windows.

### C#

We recommend install with nuget. See <https://www.nuget.org/packages/Vosk/>

To try the system

```
git clone https://github.com/alphacep/vosk-api
cd vosk-api/csharp/demo
dotnet run
```

To integrate library in your software simply execute

```
dotnet add package Vosk
```

and then follow the [example in our code](https://github.com/alphacep/vosk-api/tree/master/csharp/demo).

For details of the wrapper see the [nuget folder](https://github.com/alphacep/vosk-api/tree/master/csharp/nuget).

Nuget should work on Windows and Linux. We might add OSX later.

### Javascript/Nodejs

We implement node bindings with node-ffi-napi library and thus should support more or less recent node versions

To install node module simply run

```
npm install vosk
```

For example of the API see the [code on github](https://github.com/alphacep/vosk-api/blob/master/nodejs/demo/demo.js).
