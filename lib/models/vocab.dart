class CommonVocab {
  const CommonVocab({
    required this.id,
    required this.word,
    required this.furigana,
    required this.meaning,
  });

  final int id;
  final String word;
  final String furigana;
  final String meaning;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'furigana': furigana,
      'meaning': meaning,
    };
  }

  @override
  String toString() {
    return 'word:$word meaning: $meaning';
  }
}

class QuestionVocab {
  const QuestionVocab(
      {required this.id, required this.quesId, required this.vocabId});
  final int id;
  final int quesId;
  final int vocabId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quesId': quesId,
      'vocabId': vocabId,
    };
  }
}
