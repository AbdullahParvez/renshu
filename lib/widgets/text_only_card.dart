import 'package:flutter/material.dart';
import 'package:renshu/widgets/text_with_link.dart';

class TextOnlyCard extends StatelessWidget {
  const TextOnlyCard(
      {super.key,
      required this.text,
      this.quesNo,
      required this.year,
      required this.translation});
  final int? quesNo;
  final String text;
  final String translation;
  final String year;

  @override
  Widget build(BuildContext context) {
    // print('From text only');
    // print(text);
    return Card(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Center(
            child: TextWithLink(
              text: text,
              translation:translation,
              quesNo: quesNo,
              year: year,
            ),
          ),
        ),
      ),
    );
  }
}
