---
layout: default
title: Installation
---

## Android build

```
cd android
gradle build
```

Please note that medium blog post about 64-bit is not relevant anymore, the script builds x86, arm64 and armv7 libraries automatically without any modifications.

For example of Android application using Vosk-API check <https://github.com/alphacep/kaldi-android-demo> project

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

Make sure you have newer pip and python3:

  * Python version: 3.5-3.8 (Linux), 3.6-3.7 (ARM), 3.8 (OSX), 3.8-64bit (Windows)
  * pip version: 19.0 and newer.

Uprade python and pip if needed. Then install vosk on Linux/Mac with a simple command

```
pip3 install vosk
```

Please note that some platforms are not fully supported by pip, for example you have install on arm64 from released wheels:

```
pip3 install https://github.com/alphacep/vosk-api/releases/download/0.3.7/vosk-0.3.7-cp37-cp37m-linux_aarch64.whl
```

Also please note that Vosk requires libgfortran on some Linux builds which might be missing, you might need to install libgfortran with a
package manager.

On Windows make sure you have 64-bit Python. We do not support 32-bit python yet.

In case of trouble installing, verify and provide for analysis the output of the following commands

```
python3 --version
pip3 --version
pip3 -v install vosk
```

## Websocket Server and GRPC server

We also provide a websocket server and grpc server which can be used in telephony and other applications. With bigger models adapted for 8khz audio it provides more accuracy.

The server is installed with docker and can run with a single command:

```
docker run -d -p 2700:2700 alphacep/kaldi-en:latest
```

For details see <https://github.com/alphacep/vosk-server>


## Compilation from source

If you still want to build from scratch, you can compile Kaldi and Vosk yourself. The compilation is straightforward but might be a little confusing for newbie. In case you want to follow this, please watch the errors.

#### Kaldi compilation for local python, node and java modules

```
git clone -b lookahead --single-branch https://github.com/alphacep/kaldi
cd kaldi/tools
make
```

install all dependencies and repeat `make` if needed

```
extras/install_openblas.sh
cd ../src
./configure --mathlib=OPENBLAS --shared --use-cuda=no
make -j 10
```

#### Kaldi compilation on OSX

The process is about the same except you don't really need OpenBLAS. On OSX kaldi uses Accelerate framework.

#### Python module build

Then build the python module

```
export KALDI_ROOT=<KALDI_ROOT>
cd python
python3 setup.py install --user --single-version-externally-managed --root=/
```

#### Running the example code with python

Run like this:

```
cd vosk-api/python/example
wget https://alphacephei.com/kaldi/models/vosk-model-small-en-us-0.3.zip
unzip vosk-model-small-en-us-0.3.zip
mv vosk-model-small-en-us-0.3 model
python3 ./test_simple.py test.wav
```

To run with your audio file make sure it has proper format - PCM 16khz 16bit mono, otherwise decoding will not work.

You can find other examples of using a microphone, decoding with a fixed small vocabulary or speaker identification setup in  [python/example subfolder](https://github.com/alphacep/vosk-api/tree/master/python/example)

For more details see this video

<iframe width="560" height="315" src="https://www.youtube.com/embed/Itic1lFc4Gg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

#### Java example API build

Or Java

```
cd java && KALDI_ROOT=<KALDI_ROOT> make
wget https://alphacephei.com/kaldi/models/vosk-model-small-en-us-0.3.zip
unzip vosk-model-small-en-us-0.3.zip
mv vosk-model-small-en-us-0.3 model
make run
```

#### C# build

Or C#

```
cd csharp && KALDI_ROOT=<KALDI_ROOT> make
wget https://alphacephei.com/kaldi/models/vosk-model-small-en-us-0.3.zip
unzip vosk-model-small-en-us-0.3.zip
mv vosk-model-small-en-us-0.3 model
mono test.exe
```

