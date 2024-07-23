import 'package:csv/csv.dart';
import 'package:flutter/services.dart' as root_bundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommonVocabProviderNotifier
    extends StateNotifier<Map<String, List<String>>> {
  CommonVocabProviderNotifier() : super({}) {
    loadCommonVocab();
  }

  loadCommonVocab() async {
    var result = await root_bundle.rootBundle.loadString(
      "assets/csv/vocab.csv",
    );
    final List<dynamic> vocabList = const CsvToListConverter().convert(result);
    Map<String, List<String>> commonVocabs = {};
    for (var vocab in vocabList) {
      commonVocabs[vocab[0]] = [vocab[1], vocab[2]];
    }
    state = commonVocabs;
  }
}

final commonVocabProvider = StateNotifierProvider<CommonVocabProviderNotifier,
    Map<String, List<String>>>(
  (ref) {
    return CommonVocabProviderNotifier();
  },
);
