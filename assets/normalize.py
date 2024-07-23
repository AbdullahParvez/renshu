import pandas as pd
import re

def transform_text(text):
    pattern = r"\((\d+)?([A-Z]?)\)"   # Pattern to match "(digits)(letter)"
    result = re.sub(pattern, r"_\1\2", text)  # Replace with "_digitsletter"
    return result


questions = pd.read_excel('question/2021_second.xlsx', header=None)
questions.columns = ['no', "Eng", "Picture", "Option_1_Eng", "Option_2_Eng", "Option_3_Eng", "Option_4_Eng",
           'Ans', 'Vocab', 'Jpn', "Option_1_Jpn", "Option_2_Jpn", "Option_3_Jpn",
           "Option_4_Jpn", "Exp", 'comment']

for index, row in questions.iterrows():
    print(index)
    pic = row['Picture']
    if pd.isna(pic):
        questions.at[index, 'Picture'] = ''
    elif 'Picture' in pic:
        questions.at[index, 'Picture'] = transform_text(pic)

    op_1_en = row['Option_1_Eng']
    op_1_jp = row['Option_1_Jpn']
    if 'Picture' in op_1_en:
        op_1_en = transform_text(op_1_en)
        op_1_jp = transform_text(op_1_en)
    else:
        op_1_en = op_1_en.split('.', 1)[1].strip()
        if pd.isna(op_1_jp):
            op_1_jp = op_1_en
        else:
            op_1_jp = op_1_jp.replace('．', '. ').split('.', 1)[1].strip()

    questions.at[index, 'Option_1_Eng'] = op_1_en
    questions.at[index, 'Option_1_Jpn'] = op_1_jp
    op_4_en = row['Option_4_Eng']
    op_4_jp = row['Option_4_Jpn']

    if 'Picture' in op_4_en:
        op_4_en = transform_text(op_4_en)
        op_4_jp = transform_text(op_4_en)
    else:
        op_4_en = op_4_en.split('.', 1)[1].strip()
        if pd.isna(op_4_jp):
            op_4_jp = op_4_en
        else:
            op_4_jp = op_4_jp.replace('．', '. ').split('.', 1)[1].strip()
    questions.at[index, 'Option_4_Eng'] = op_4_en
    questions.at[index, 'Option_4_Jpn'] = op_4_jp

    op_2_en = row['Option_2_Eng']
    op_2_jp = row['Option_2_Jpn']

    if 'Picture' in op_2_en:
        op_2_en = transform_text(op_2_en)
        op_2_jp = transform_text(op_2_en)
    else:
        op_2_en = op_2_en.split('.', 1)[1].strip()
        if pd.isna(op_2_jp):
            op_2_jp = op_2_en
        else:
            op_2_jp = op_2_jp.replace('．', '. ').split('.', 1)[1].strip()
    questions.at[index, 'Option_2_Eng'] = op_2_en
    questions.at[index, 'Option_2_Jpn'] = op_2_jp

    op_3_en = row['Option_3_Eng']
    op_3_jp = row['Option_3_Jpn']
    # print(op_3_en)

    if 'Picture' in op_3_en:
        op_3_en = transform_text(op_3_en)
        op_3_jp = transform_text(op_3_en)
    else:
        op_3_en = op_3_en.split('.', 1)[1].strip()
        if pd.isna(op_3_jp):
            op_3_jp = op_3_en
        else:
            op_3_jp = op_3_jp.replace('．', '. ').split('.', 1)[1].strip()
    questions.at[index, 'Option_3_Eng'] = op_3_en
    questions.at[index, 'Option_3_Jpn'] = op_3_jp

    ans = row['Ans']
    if 'Picture' in ans:
        ans = transform_text(ans.split('Ans:')[1])
        if ans.strip()==op_1_en.strip():
            questions.at[index, 'Ans'] = '1'
        elif ans.strip()==op_2_en.strip():
            questions.at[index, 'Ans'] = '2'
        elif ans.strip()==op_3_en.strip():
            questions.at[index, 'Ans'] = '3'
        elif ans.strip()==op_4_en.strip():
            questions.at[index, 'Ans'] = '4'
    else:
        if 'Ans :' in ans:
            ans = ans.replace('Ans :', 'Ans:')
        print(ans)
        questions.at[index, 'Ans'] = (ans.split('Ans:')[1]).split('.', 1)[0].strip()
    vocabs = ''
    # print(row['Vocab'])
    if not pd.isna(row['Vocab']):
        # print('dkdk')
        vocabs = [vocab.replace('\u200b', '') for vocab in row['Vocab'].split('\n') if vocab.strip()]
    questions.at[index, 'Vocab'] = vocabs

    comment = ''
    if not pd.isna(row['comment']):
        comment = row['comment'].replace(' 1st Half', '_1, ')
        comment = comment.replace(' 2nd Half', '_2, ')
    questions.at[index, 'comment']=comment

print(questions.head())
questions.to_excel('2021_second.xlsx')