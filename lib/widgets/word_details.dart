import 'package:flutter/material.dart';

class WordDetails extends StatelessWidget {
  const WordDetails(
      {super.key,
      required this.vocab,
      required this.furigana,
      required this.meaning});

  final String vocab;
  final String furigana;
  final String meaning;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                vocab,
                style: const TextStyle(
                  fontSize: 40.0,
                  color: Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Text(
                furigana,
                style: const TextStyle(
                  fontSize: 24.0,
                  color: Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Text(
                meaning,
                style: const TextStyle(
                  fontSize: 26.0,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              )),
              child: const Text(
                'Close',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
