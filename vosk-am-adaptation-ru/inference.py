from multiprocessing.dummy import Pool
from vosk import Model, KaldiRecognizer

import os
import sys
import wave
import json
import pickle
import pandas as pd
from jiwer import wer


with open('wav_text.pkl', 'rb') as f:
    wav_to_text = pickle.load(f)

if sys.argv[2] == 'old':
    model = Model("vosk-model-ru-0.10")
else:
    model = Model('vosk-model-ru-tuned')
    
def recognize(line):
    uid, fn = line.split()
    wf = wave.open(fn, "rb")
    rec = KaldiRecognizer(model, wf.getframerate())
    text = ""
    while True:
        data = wf.readframes(4000)
        if len(data) == 0:
            break
        if rec.AcceptWaveform(data):
            jres = json.loads(rec.Result())
            text = text + " " + jres['text']
    jres = json.loads(rec.FinalResult())
    text = text + " " + jres['text']
    truth = wav_to_text[uid]
    score = wer(truth, text)
    return score, text

def main():
    p = Pool(80)
    results = p.map(recognize, open(sys.argv[1]).readlines())
    df = pd.DataFrame(results, columns=["wer", "transcribe"])
    print('MEAN WER: ', df.wer.mean())
    df.to_csv("log_inference.csv", index=False)

main()
