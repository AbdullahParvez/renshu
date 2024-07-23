import 'package:flutter/material.dart';

import '../widgets/text_with_link.dart';

class FullScreen extends StatelessWidget {
  const FullScreen(this.text, this.translation, this.figure, this.year, {super.key});
  final String text;
  final String translation;
  final String figure;
  final String year;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextWithLink(
              text: text,
              year:year, translation: translation,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/$year/${figure.trim()}.PNG',
              scale: 2,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
