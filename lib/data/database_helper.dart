import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' as root_bundle;

Future<Database> _getDatabase() async {
  const String databaseName = "question_database.db";
  final dbPath = await getDatabasesPath();
  final db = await openDatabase(
    path.join(dbPath, databaseName),
    onCreate: (db, version) async {
      await db.execute('''  
        CREATE TABLE vocab (
        vocabId INTEGER PRIMARY KEY,
        word TEXT,
        pronunciation TEXT,
        meaning TEXT,
        chapter INTEGER NOT NULL,
        FOREIGN KEY (chapter) REFERENCES chapter (chapterId) ON DELETE CASCADE
       )''');

      await db.execute("CREATE TABLE chapter ("
          "chapterId INTEGER PRIMARY KEY,"
          "no INTEGER NOT NULL,"
          "unit INTEGER NOT NULL,"
          "is_completed INTEGER DEFAULT 0 NOT NULL,"
          "FOREIGN KEY (unit) REFERENCES unit (unitId) ON DELETE CASCADE"
          ")");
      await db.execute("CREATE TABLE unit ("
          "unitId INTEGER PRIMARY KEY,"
          "no INTEGER NOT NULL,"
          "level INTEGER NOT NULL,"
          "FOREIGN KEY (level) REFERENCES jlpt (levelId) ON DELETE CASCADE"
          ")");
      await db.execute("CREATE TABLE jlpt ("
          "levelId INTEGER PRIMARY KEY,"
          "level TEXT"
          ")");
      await db.execute("CREATE TABLE kanji ("
          "kanjiId INTEGER PRIMARY KEY,"
          "kanji TEXT,"
          "onyomi TEXT,"
          "kunyomi TEXT,"
          "meaning Text"
          ")");

      await db.execute(
          "INSERT INTO jlpt ('levelId', 'level') values (?, ?)", [1, "N1"]);
      await db.execute(
          "INSERT INTO jlpt ('levelId', 'level') values (?, ?)", [2, "N2"]);
      await db.execute(
          "INSERT INTO jlpt ('levelId', 'level') values (?, ?)", [3, "N3"]);
      await db.execute(
          "INSERT INTO jlpt ('levelId', 'level') values (?, ?)", [4, "N4"]);
      await db.execute(
          "INSERT INTO jlpt ('levelId', 'level') values (?, ?)", [5, "N5"]);
      // print('Created');
      await _loadVocab(db, 5);
      await _loadVocab(db, 4);
      await _loadVocab(db, 3);
      await _loadVocab(db, 2);
      await _loadVocab(db, 1);
      await _loadKanji(db);
      // print('Loaded');
    },
    version: 1,
  );

  return db;
}

_loadVocab(Database db, int level) async {
  // print('Loading.....');
  final String response = await root_bundle.rootBundle
      .loadString('assets/json/n${level}_vocab_data.json');
  final data = await json.decode(response);
  Batch batch = db.batch();
  for (Map<String, dynamic> d in data) {
    d.forEach((key, value) async {
      int unit = int.parse(key.split('_')[1]);
      batch.insert("unit", {'unitId': value['id'], 'no': unit, 'level': level});
      value['sets'].forEach((innKey, innValue) async {
        int set = int.parse(innKey.split('_')[1]);
        batch.insert("chapter", {
          'chapterId': innValue['id'],
          'no': set,
          'is_completed': 0,
          'unit': value['id']
        });
        for (var vocab in innValue['vocabs']) {
          batch.insert("vocab", {
            'vocabId': vocab['id'],
            'word': vocab['word'],
            'pronunciation': vocab['pronunciation'],
            'meaning': vocab['meaning'],
            'chapter': innValue['id'],
          });
        }
      });
    });
    var results = await batch.commit();
  }
}

_loadKanji(Database db) async {
  Batch batch = db.batch();

  var result = await root_bundle.rootBundle.loadString(
    "assets/csv/kanji.csv",
  );
  final List<dynamic> kanjiList =
  const CsvToListConverter().convert(result, eol: "\n");
  int count = 0;
  // print(kanjiList);
  for (var k in kanjiList) {
    // print(k[1]);
    if (count != 0) {
      var kanji = k[1];
      var kunyomi = k[2];
      var onyomi = k[3];
      var meaning = k[4];
      // print('$count $kanji $kunyomi $onyomi $meaning');
      batch.insert("kanji", {
        'kanjiId': count,
        'kanji': kanji,
        'kunyomi': kunyomi,
        'onyomi': onyomi,
        'meaning': meaning,
      });
    }

    count++;
  }
  var results = await batch.commit();
}

Future<bool> createDatabase() async {
  _getDatabase();
  return true;
}
//
// Future<List<Unit>> fetchAllUnitByLevel(int level) async {
//   // print('All Unit');
//   final db = await _getDatabase();
//   List<Map<String, dynamic>> units =
//   await db.query("unit", where: "level = ?", whereArgs: [level]);
//   // print(units);
//   return List.generate(units.length, (i) {
//     return Unit(
//       id: units[i]['unitId'],
//       no: units[i]['no'],
//       level: units[i]['level'],
//     );
//   });
// }
//
// Future<List<QuestionSet>> fetchAllSetByUnit(int unit) async {
//   // print('All Set');
//   final db = await _getDatabase();
//   List<Map<String, dynamic>> sets =
//   await db.query("chapter", where: "unit = ?", whereArgs: [unit]);
//   return List.generate(sets.length, (i) {
//     return QuestionSet(
//       id: sets[i]['chapterId'],
//       no: sets[i]['no'],
//       isCompleted: sets[i]['is_completed'],
//       unit: sets[i]['unit'],
//     );
//   });
// }
//
// Future<List<Vocab>> fetchAllVocabBySet(int set) async {
//   // print('All Vocab');
//   final db = await _getDatabase();
//   List<Map<String, dynamic>> vocabs =
//   await db.query("vocab", where: "chapter = ?", whereArgs: [set]);
//   return List.generate(vocabs.length, (i) {
//     return Vocab(
//       id: vocabs[i]['vocabId'],
//       word: vocabs[i]['word'],
//       pronunciation: vocabs[i]['pronunciation'],
//       meaning: vocabs[i]['meaning'],
//       set: vocabs[i]['chapter'],
//     );
//   });
// }
//
// Future<QuestionSet> getQuesSet(int no) async {
//   final db = await _getDatabase();
//   List<Map<String, dynamic>> quesSet =
//   await db.query("chapter", where: "chapterId = ?", whereArgs: [no]);
//   return QuestionSet(
//     id: quesSet[0]['chapterId'],
//     no: quesSet[0]['no'],
//     isCompleted: quesSet[0]['is_completed'],
//     unit: quesSet[0]['unit'],
//   );
// }
//
// Future<void> updateSetCheckCompleted(int id, QuestionSet questionSet) async {
//   // Get a reference to the database.
//   final db = await _getDatabase();;
//
//   await db.update(
//     'chapter',
//     questionSet.toMap(),
//     where: 'chapterId = ?',
//     whereArgs: [id],
//   );
// }
//
// Future<bool> checkKanji(kanji) async {
//   final db = await _getDatabase();
//   List<Map<String, dynamic>> kanjis =
//   await db.query("kanji", where: "kanji = ?", whereArgs: [kanji]);
//   if (kanjis.isNotEmpty) {
//     return true;
//   }
//   return false;
// }
//
// Future<Kanji> getKanji(kanji) async {
//   final db = await _getDatabase();
//   List<Map<String, dynamic>> kanjis =
//   await db.query("kanji", where: "kanji = ?", whereArgs: [kanji]);
//   return Kanji(
//     id: kanjis[0]['kanjiId'],
//     kanji: kanjis[0]['kanji'],
//     kunyomi: kanjis[0]['kunyomi'],
//     onyomi: kanjis[0]['onyomi'],
//     meaning: kanjis[0]['meaning'],
//   );
// }
//
// Future<List<Kanji>> fetchAllKanji() async {
//   // print('All Vocab');
//   final db = await _getDatabase();
//   List<Map<String, dynamic>> kanjis = await db.query("kanji");
//   return List.generate(kanjis.length, (i) {
//     return Kanji(
//       id: kanjis[i]['kanjiId'],
//       kanji: kanjis[i]['kanji'],
//       kunyomi: kanjis[i]['kunyomi'],
//       onyomi: kanjis[i]['onyomi'],
//       meaning: kanjis[i]['meaning'],
//     );
//   });
// }
