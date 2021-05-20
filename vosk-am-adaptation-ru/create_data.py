import os
import sys
import pandas as pd


def writeTextFile(text_file, ids, recognitions):
    f = open(text_file, "w")
    for id, recognition in zip(ids, recognitions):
        f.write(id + " " + recognition + "\n")
    f.close()

    
def writeSpeakerToUtterance(stu_file, speakers, ids):
    f = open(stu_file, "w")
    for id, speaker in zip(ids, speakers):
        f.write(speaker + " " + id + "\n")
    f.close()

    
def create_kaldi_format_data(root_path):
    
    meta_path = os.path.join(root_path, 'metadata.csv')
    wavs_path = os.path.join(root_path, 'wavs')
    
    meta_data = pd.read_csv(meta_path, sep='|', header=None)
    
    test  = meta_data.sample(1000)
    train = meta_data[~meta_data.isin(test.index)]
    
    train['Recognition'] = train[1].apply(lambda row: ' '.join(re.findall("[А-Яа-яЁё]+", row)).lower().strip())
    test['Recognition']  =  test[1].apply(lambda row: ' '.join(re.findall("[А-Яа-яЁё]+", row)).lower().strip())
    
    train['Directory'] = wavs_path
    test['Directory']  = wavs_path
 
    train['File'] = train[0] + '.wav'
    test['File']  = test[0] + '.wav'
    
    train['FilePure'] = train[0].str.split('_').apply(lambda row: row[1])
    test['FilePure']  = test[0].str.split('_').apply(lambda row: row[1])
    
    train['Fullfile'] = train['Directory'].astype(str) + '/' + train['File'].astype(str) 
    test['Fullfile']  = test['Directory'].astype(str) + '/' + test['File'].astype(str) 

    
    for filename, directory in [(train, 'train'), (test, 'test')]:

        filename = filename.sort_values(by="FilePure")

        print("Writing data directory:", directory)
        os.makedirs("data/" + directory)
        print("")
        scp_file = "data/" + directory + "/wav.scp"
        print("Writing scp file: {} .. ".format(scp_file), end='')
        filename.to_csv(scp_file, sep=" ", header=0, index=False, columns=["FilePure","Fullfile"])
        print("done.")

        uts_file = "data/" + directory + "/utt2spk"
        print("Writing utt2spk file: {} .. ".format(uts_file), end='')
        filename.to_csv(uts_file, sep=" ", header=0, index=False, columns=["FilePure","FilePure"])
        print("done.")

        stu_file = "data/" + directory + "/spk2utt"
        print("Writing spk2utt file: {} .. ".format(stu_file), end='')
        writeSpeakerToUtterance(stu_file, filename["FilePure"], filename["FilePure"])
        print("done.")

        corpus_file = "data/" + directory + "/corpus.txt"
        print("Writing corpus file: {} .. ".format(corpus_file), end='')
        filename.to_csv(corpus_file, sep="\t", header=0, index=False, columns=["Recognition"])
        print("done.")

        text_file = "data/" + directory + "/text"
        print("Writing text file: {} .. ".format(text_file), end='')
        writeTextFile(text_file, filename["FilePure"], filename["Recognition"])
        print("done.")
        print("")
        print("")

    return 0

def main():
    create_kaldi_format_data(root_path=sys.argv[1])
