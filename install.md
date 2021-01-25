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

  * Python version: 3.5-3.8 (Linux), 3.6-3.7 (ARM), 3.8-3.9 (OSX), 3.8-64bit (Windows)
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

Follow this process from our [docker](https://github.com/alphacep/vosk-api/blob/master/travis/Dockerfile.manylinux#L26):

```
    git clone -b lookahead-1.8.0 --single-branch https://github.com/alphacep/kaldi \
    && cd /opt/kaldi/tools \
    && git clone -b v0.3.13 --single-branch https://github.com/xianyi/OpenBLAS \
    && git clone -b v3.2.1  --single-branch https://github.com/alphacep/clapack \
    && make -C OpenBLAS ONLY_CBLAS=1 DYNAMIC_ARCH=1 TARGET=NEHALEM USE_LOCKING=1 USE_THREAD=0 all \
    && make -C OpenBLAS PREFIX=$(pwd)/OpenBLAS/install install \
    && mkdir -p clapack/BUILD && cd clapack/BUILD && cmake .. && make -j 10 && find . -name "*.a" | xargs cp -t ../../OpenBLAS/install/lib \
    && cd /opt/kaldi/tools \
    && git clone --single-branch https://github.com/alphacep/openfst openfst \
    && cd openfst \
    && autoreconf -i \
    && CFLAGS="-g -O3" ./configure --prefix=/opt/kaldi/tools/openfst --enable-static --enable-shared --enable-far --enable-ngram-fsts --enable-lookahead-fsts --with-pic --disable-bin \
    && make -j 10 && make install \
    && cd /opt/kaldi/src \
    && ./configure --mathlib=OPENBLAS_CLAPACK --shared --use-cuda=no \
    && sed -i 's: -O1 : -O3 :g' kaldi.mk \
    && make -j $(nproc) online2 lm rnnlm
```

#### Python module build

Then clone the vosk-api project and build the python module:

```sh
git clone https://github.com/alphacep/vosk-api
cd vosk-api/python
KALDI_ROOT=<KALDI_ROOT> python3 setup.py install --user --single-version-externally-managed --root=/
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

When using your own audio file make sure it has the correct format - PCM 16khz 16bit mono. Otherwise, if you have ffmpeg installed, you can use `test_ffmpeg.py`, which does the conversion for you.
Find more examples such as using a microphone, decoding with a fixed small vocabulary or speaker identification setup in the [python/example subfolder](https://github.com/alphacep/vosk-api/tree/master/python/example)

For more info see this video:

<iframe width="560" height="315" src="https://www.youtube.com/embed/Itic1lFc4Gg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### Java

```
git clone https://github.com/alphacep/vosk-api
cd vosk-api/java && KALDI_ROOT=<KALDI_ROOT> make
wget https://alphacephei.com/kaldi/models/vosk-model-small-en-us-0.15.zip
unzip vosk-model-small-en-us-0.15.zip
mv vosk-model-small-en-us-0.15 model
make run
```

### C#

```
git clone https://github.com/alphacep/vosk-api
cd vosk-api/csharp && KALDI_ROOT=<KALDI_ROOT> make
wget https://alphacephei.com/kaldi/models/vosk-model-small-en-us-0.15.zip
unzip vosk-model-small-en-us-0.15.zip
mv vosk-model-small-en-us-0.15 model
mono test.exe
```

We also have Nuget package, currently only Linux is supported, we plan to
add Windows and OSX binaries soon. See <https://www.nuget.org/packages/Vosk/>

