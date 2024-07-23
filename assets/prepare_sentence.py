import pandas as pd
import re

def transform_text(text):
    pattern = r"\((\d+)?([A-Z]?)\)"   # Pattern to match "(digits)(letter)"
    result = re.sub(pattern, r"_\1\2", text)  # Replace with "_digitsletter"
    return result

vocab_list = []
more_vocabs = pd.read_csv('csv/vocab.csv')
for index, row in more_vocabs.iterrows():
    if row[0] not in vocab_list:
        vocab_list.append(row[0])

sorted_vocab = sorted(vocab_list, key=len, reverse=True)
# print(sorted_vocab)
questions = pd.read_excel('question/2020_first.xlsx', header=None)
questions.columns = ['','no', "Eng", "Picture", "Option_1_Eng", "Option_2_Eng", "Option_3_Eng", "Option_4_Eng",
                     'Ans', 'Vocab', 'Jpn', "Option_1_Jpn", "Option_2_Jpn", "Option_3_Jpn",
                     "Option_4_Jpn", "Exp", 'comment']

for index, row in questions.iterrows():
    jpn = row['Jpn']
    op_1_jp = row['Option_1_Jpn']
    op_2_jp = row['Option_2_Jpn']
    op_3_jp = row['Option_3_Jpn']
    op_4_jp = row['Option_4_Jpn']
    jpn_word_list = []
    op_1_jp_word_list = []
    op_2_jp_word_list = []
    op_3_jp_word_list = []
    op_4_jp_word_list = []
    for vocab in vocab_list:

        if vocab in jpn:
            if not any(vocab in s for s in jpn_word_list):
                jpn = jpn.replace(vocab, '{'+vocab+'}')
                jpn_word_list.append(vocab)

        if vocab in op_1_jp:
            if not any(vocab in s for s in op_1_jp_word_list):
                op_1_jp = op_1_jp.replace(vocab, '{'+vocab+'}')
                op_1_jp_word_list.append(vocab)

        if vocab in op_2_jp:
            if not any(vocab in s for s in op_2_jp_word_list):
                op_2_jp = op_2_jp.replace(vocab, '{'+vocab+'}')
                op_2_jp_word_list.append(vocab)

        if vocab in op_3_jp:
            if not any(vocab in s for s in op_3_jp_word_list):
                op_3_jp = op_3_jp.replace(vocab, '{'+vocab+'}')
                op_3_jp_word_list.append(vocab)

        if vocab in op_4_jp:
            if not any(vocab in s for s in op_4_jp_word_list):
                op_4_jp = op_4_jp.replace(vocab, '{'+vocab+'}')
                op_4_jp_word_list.append(vocab)

    questions.at[index, 'Jpn'] = jpn
    questions.at[index, 'Option_1_Jpn'] = op_1_jp
    questions.at[index, 'Option_2_Jpn'] = op_2_jp
    questions.at[index, 'Option_3_Jpn'] = op_3_jp
    questions.at[index, 'Option_4_Jpn'] = op_4_jp

    print(jpn, op_1_jp, op_2_jp, op_3_jp, op_4_jp)


# print(questions.head())
questions.to_excel('2020_1.xlsx')