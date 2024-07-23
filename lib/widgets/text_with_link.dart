import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:renshu/widgets/translation.dart';
import 'package:renshu/widgets/word_details.dart';

import '../providers/common_vocab_provider.dart';
import '../screens/full_image_screen.dart';
import 'image_bottom_sheet.dart';

class TextWithLink extends ConsumerWidget {
  final String text;
  final int? quesNo;
  final String year;
  final String translation;
  static final regex = RegExp("(?={)|(?<=})");

  const TextWithLink({
    super.key,
    required this.text,
    this.quesNo,
    required this.year,
    required this.translation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, List<String>> commonVocabs =
        ref.watch(commonVocabProvider);
    final split = text.split(regex);
    if (text == translation) {
      return Text(
        split[0],
        style: const TextStyle(fontSize: 18.0, color: Colors.black),
      );
    } else {
      return RichText(
        text: TextSpan(
          children: <InlineSpan>[
            for (String text in split)
              if (!(text.startsWith('{') && text.length < 2))
                text.startsWith('{')
                    ? TextSpan(
                        text: text.substring(1, text.length - 1),
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            String vocab = text.substring(1, text.length - 1);
                            showDialog(
                              context: context,
                              builder: (context) => WordDetails(
                                vocab: vocab,
                                furigana: commonVocabs[vocab]![0],
                                meaning: commonVocabs[vocab]![1],
                              ),
                            );
                          },
                      )
                    : TextSpan(
                        text: text,
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.black),
                      ),
            if (quesNo != null && quesNo! >= 30)
              WidgetSpan(
                child: CircleAvatar(
                  backgroundColor: Colors.lightGreen[100],
                  radius: 12,
                  child: InkWell(
                    child: const Text(
                      "図",
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      showImageBottomSheet(context, year);
                    },
                  ),
                ),
              ),
            const WidgetSpan(
              child: SizedBox(width: 6),
            ),
            WidgetSpan(
              child: CircleAvatar(
                backgroundColor: Colors.lightBlue[100],
                radius: 12,
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(
                    Icons.title,
                    color: Colors.black,
                    size: 20.0,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Translation(
                        text: translation,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

void showImageBottomSheet(BuildContext context, String year) {
  final height = MediaQuery.of(context).size.height * 0.8;
  final String imageUrl = 'assets/images/$year/last_one.PNG';
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allow scrolling if image is large
    builder: (BuildContext context) {
      return ImageBottomSheet(height: height, imageUrl: imageUrl, year: year,);
    },
  );
}


