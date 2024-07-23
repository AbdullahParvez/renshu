class QuestionFields {
    static const String tableName = 'questions';
    static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    static const String textType = 'TEXT NOT NULL';
    static const String intType = 'INTEGER NOT NULL';
    static const String id = '_id';
    static const String title = 'year';
    static const String shift = 'shift';
}

class Question{

    const Question({
        required this.id,
        required this.year,
        required this.shift,
});
    final int id;
    final int year;
    final int shift;

    Map<String, dynamic> toMap() {
        return {
            'id': id,
            'year':year,
            'shift': shift,
        };
    }
    @override
  String toString() {
    return 'year:$year shift: $shift';
  }
}

class QuestionDetails{

    const QuestionDetails({
        required this.id,
        required this.quesNo,
        required this.questionId,
        required this.textJpn,
        required this.textEng,
        this.option_1Jpn,
        this.option_2Jpn,
        this.option_3Jpn,
        this.option_4Jpn,
        this.option_1Eng,
        this.option_2Eng,
        this.option_3Eng,
        this.option_4Eng,
        this.mainTextPic,
        this.option_1Pic,
        this.option_2Pic,
        this.option_3Pic,
        this.option_4Pic,
        this.explanation,
        this.reference,
});
    final int id;
    final int quesNo;
    final int questionId;
    final String textJpn;
    final String? option_1Jpn;
    final String? option_2Jpn;
    final String? option_3Jpn;
    final String? option_4Jpn;
    final String textEng;
    final String? option_1Eng;
    final String? option_2Eng;
    final String? option_3Eng;
    final String? option_4Eng;
    final String? mainTextPic;
    final String? option_1Pic;
    final String? option_2Pic;
    final String? option_3Pic;
    final String? option_4Pic;
    final String? explanation;
    final String? reference;

    Map<String, dynamic> toMap() {
        return {
            'id': id,
            'quesNo':quesNo,
            'questionId':questionId,
            'textJpn': textJpn,
            'option_1Jpn': option_1Jpn,
            'option_2Jpn': option_2Jpn,
            'option_3Jpn': option_3Jpn,
            'option_4Jpn': option_4Jpn,
            'textEng': textEng,
            'option_1Eng': option_1Eng,
            'option_2Eng': option_2Eng,
            'option_3Eng': option_3Eng,
            'option_4Eng': option_4Eng,
            'mainTextPic': mainTextPic,
            'option_1Pic': option_1Pic,
            'option_2Pic': option_2Pic,
            'option_3Pic': option_3Pic,
            'option_4Pic': option_4Pic,
            'explanation':explanation,
            'reference':reference,
        };
    }

    @override
  String toString() {
      return 'Question:$textJpn';
  }
}