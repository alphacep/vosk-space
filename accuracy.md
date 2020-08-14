---
layout: default
---

## Accuracy issues

Accuracy of modern systems is still unstable, that means sometimes you
can have a very good accuracy and sometimes it could be bad. It is hard
to make a system that will work good in any condition. And there could be
many reasons for that:

  * Audio has very bad quality
  * Vocabulary of the system doesn't match (yes, most of the systems, even end-to-end ones still use a fixed vocabulary)
  * Audio conditions like accent are not really the ones that were used in training
  * Some unpredictable audio issues like frame drop or frame coding bugs
  * Software bugs

The first step in understanding the accuracy issue is to debug the
problem and understand which of many components in the system cause bad
accuracy. There are many ways to investigate that, the major ones are:

  * Make sure that the audio is good quality by listening it
  * Make sure that language model and the vocabulary are relevant by
    calculation of the OOV rate and language model perplexity
  * Make sure that acoustic model is relevant by estimation of the
   accuracy with the tuned langauge model or by estimation of the oracle
   lattice accuracy
  * Make sure that algorithms implemented are following best industry practices
  * Make sure that software doesn't have bugs by comparision with the
    batch task setup or with a different software (yes, bugs also happen!)

Note that it is hard to guess what is going on under the hood without
getting the hands dirty. For that reason if you are seeking help on
accuracy issues you must provide the following for analysis:

  * Who are you, where are you from and why are you doing that. We don't like dealing with anonymous users
  * The complete and exact description of the system you want to build - what is it going to do, what do you want to build
  * The precise description of hardware you are trying to run the system on
  * The detailed list of software versions you are using
  * Audio samples to demonstrate the problem together with the reference transcription for those samples

Remember, the more information you provide the faster you get a solution.

Once you figure out the weakness of the current setup you might try to solve it:

  * Adapt the models using more data following [adaptation](adaptation) document
  * Fix bugs in the software
  * Implement required algorithms
  * Implement better audio recording and delivery


