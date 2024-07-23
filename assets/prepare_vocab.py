import pandas as pd
import re
import csv

examList = [
    '2011_1',
    '2011_2',
    '2012_1',
    '2012_2',
    '2013_1',
    '2013_2',
    '2014_1',
    '2014_2',
    '2015_1',
    '2015_2',
    '2016_1',
    '2016_2',
    '2017_1',
    '2017_2',
    '2018_1',
    '2018_2',
    '2019_1',
    '2019_2',
    '2020_1',
    '2020_2',
    '2021_1',
    '2021_2',
]
word_dic = {}
for exam in examList:
    list = exam.split('_')
    # print(list[0])
    questions = None
    if '1' in exam:
        questions = pd.read_excel('question/'+list[0]+'_first.xlsx', header=None)
    else:
        questions = pd.read_excel('question/'+list[0]+'_second.xlsx', header=None)

    for index, row in questions.iterrows():
        if index>0:
            if row[9]:
                if not pd.isna(row[9]):
                    data = re.sub(r"[\[\]]",'', row[9])
                    words = data.split("', '")
                    for word in words:
                        parts = word.replace("'","").split('-')
                        details = parts[0]
                        meaning = parts[1]
                        vocab_parts = details.split('(')
                        vocab = vocab_parts[0]
                        pronc = vocab_parts[1].replace(')', '')
                        if vocab not in word_dic:
                            word_dic[vocab] = [pronc, meaning]
# print(len(word_dic))

more_vocabs = pd.read_csv('csv/electricity_vocab.csv')
for index, row in more_vocabs.iterrows():
    if row[0] not in word_dic:
        word_dic[row[0]] = [row[1], row[2]]
# print(len(word_dic))
word_list = []
for key, val in word_dic.items():
    word_list.append([key, val[0], val[1]])

with open('csv/vocab.csv', 'w') as f:

    # Create a CSV writer object that will write to the file 'f'
    csv_writer = csv.writer(f)

    # Write all of the rows of data to the CSV file
    csv_writer.writerows(word_list)