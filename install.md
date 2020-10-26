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

Please note that medium blog post about 64-bit is not relevant anymore, the script builds x86, arm64 and armv7 libraries automatically without any modifications.

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

  * Python version: 3.5-3.8 (Linux), 3.6-3.7 (ARM), 3.8 (OSX), 3.8-64bit (Windows)
  * pip version: 19.0 and newer.

Uprade python and pip if needed. Then install vosk on Linux/Mac from pip:
```sh
pip3 install vosk
```

Please note that some platforms are not fully supported by pip, for example on arm64 you have install from released wheels:
```sh
pip3 install https://github.com/alphacep/vosk-api/releases/download/0.3.7/vosk-0.3.7-cp37-cp37m-linux_aarch64.whl
```

Also please note that Vosk requires libgfortran on some Linux builds which might be missing, you might need to install libgfortran with a
package manager.

On Windows make sure you have 64-bit Python. We do not support 32-bit python yet.


If you have trouble installing, check the output of the following commands and provide it for reference:
```sh
python3 --version
pip3 --version
pip3 -v install vosk
```

## Websocket Server and GRPC server

We also provide a websocket server and grpc server which can be used in telephony and other applications. With bigger models adapted for 8khz audio it provides more accuracy.

The server is installable from docker and can be run with a single command:
```sh
docker run -d -p 2700:2700 alphacep/kaldi-en:latest
```

For details see <https://github.com/alphacep/vosk-server>

## Compilation from source

If you still want to build from scratch, you can compile Kaldi and Vosk yourself. The compilation is straightforward but might be a little confusing for a newbie. In case you want to follow this, please watch the errors.

#### Kaldi compilation for local python, node and java modules

```sh
git clone -b lookahead --single-branch https://github.com/alphacep/kaldi
cd kaldi/tools
make
```

Install all dependencies and repeat `make` if needed.

Install OpenBLAS (on OSX you can skip this, as kaldi uses the Accelerate framework):

```sh
extras/install_openblas.sh
cd ../src
./configure --mathlib=OPENBLAS --shared --use-cuda=no
make -j 10
```

#### Python module build

Then build the python module
```sh
export KALDI_ROOT=<KALDI_ROOT>
cd python
python3 setup.py install --user --single-version-externally-managed --root=/
```

## Usage examples

### Python

Clone the [vosk-api](https://github.com/alphacep/vosk-api) and run the following commands:
```
cd vosk-api/python/example
wget https://alphacephei.com/kaldi/models/vosk-model-small-en-us-0.4.zip
unzip vosk-model-small-en-us-0.4.zip
mv vosk-model-small-en-us-0.4 model
python3 ./test_simple.py test.wav
```

When using your own audio file make sure it has the correct format - PCM 16khz 16bit mono. Otherwise, if you have ffmpeg installed, you can use `test_ffmpeg.py`, which does the conversion for you.
Find more examples such as using a microphone, decoding with a fixed small vocabulary or speaker identification setup in the [python/example subfolder](https://github.com/alphacep/vosk-api/tree/master/python/example)

For more info see this video:

<iframe width="560" height="315" src="https://www.youtube.com/embed/Itic1lFc4Gg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### Java

```
cd java && KALDI_ROOT=<KALDI_ROOT> make
wget https://alphacephei.com/kaldi/models/vosk-model-small-en-us-0.4.zip
unzip vosk-model-small-en-us-0.4.zip
mv vosk-model-small-en-us-0.4 model
make run
```

### C#

```
cd csharp && KALDI_ROOT=<KALDI_ROOT> make
wget https://alphacephei.com/kaldi/models/vosk-model-small-en-us-0.4.zip
unzip vosk-model-small-en-us-0.4.zip
mv vosk-model-small-en-us-0.4 model
mono test.exe
```

We also have Nuget package, currently only Linux is supported, we plan to
add Windows and OSX binaries soon. See <https://www.nuget.org/packages/Vosk/>

