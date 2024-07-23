import 'package:flutter/material.dart';
import 'package:renshu/screens/full_image_screen.dart';
import 'package:renshu/widgets/text_with_link.dart';

class ImageAndTextCard extends StatelessWidget {
  const ImageAndTextCard({
    super.key,
    required this.text,
    this.figure,
    this.quesNo,
    required this.year,
    required this.translation,
  });

  final String text;
  final String translation;
  final String? figure;
  final int? quesNo;
  final String year;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {},
                onDoubleTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          FullImageScreen(figure: figure!, year: year),
                    ),
                  );
                },
                splashColor: Colors.white10,
                child: Image.asset(
                  'assets/images/$year/$figure.PNG',
                  scale: 3,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
              child: TextWithLink(
                text: text,
                year: year,
                translation: translation,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
