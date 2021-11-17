---
layout: default
title: FAQ
permalink: /faq
---

# Frequently Asked Questions

## What is the difference between Kaldi and Vosk

Kaldi is a research speech recognition toolkit which implements many
state of the art algorithms. Vosk is a practical speech recognition
library which comes with a set of accurate models, scripts, practices and
provides ready to use speech recognition for different platforms like
mobile applications or Raspberry Pi. If you are doing research, Kaldi is
probably your way. If you want to build practical applications with plug
and play library, consider Vosk.

Vosk reuses best practices for accurate speech recognition from many
other toolkits, not just Kaldi. In our research we use Nvidia Nemo,
Fairseq and many other open source libraries, our goal is to build
life-long learning platform which continuously improves speech
recognition for major langauges and use cases.

Stay tuned!

## Where can I get better model

We train our models on thousands hours of speech data, they should be
pretty good out of box. Still, if you look for better accuracy [contact
us](mailto:contact@alphacephei.com), we will try to help you.

## My accuracy is not so great

Try to reproduce the problem with a file recording and share it with us,
we will check.

## How to add support for a new language

The process of building a new language model consists of the following
steps:

  * Data collection (you can collect audiobooks with text transcriptoin
    from project like librivox, transcribed podcasts, or setup web data
    collection.
  * Data cleanup
  * Model training
  * Testing

We can help you with the steps since we are interested to support as many
langauges as possible. Feel free to contact us.

