import 'package:flutter/material.dart';
import 'package:renshu/screens/full_image_screen.dart';
import 'package:renshu/widgets/text_with_link.dart';

class TextAndImageCard extends StatelessWidget {
  const TextAndImageCard({
    super.key,
    required this.text,
    required this.figure,
    required this.quesNo,
    required this.year,
    required this.translation,
  });

  final String text;
  final String translation;
  final String figure;
  final int quesNo;
  final String year;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextWithLink(
                text: text,
                year: year,
                translation: translation,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/$year/${figure!.trim()}.PNG',
                scale: 3,
                fit: BoxFit.fill,
              ),
              // child: InkWell(
              //   onTap: (){
              //
              //   },
              //   onDoubleTap: () {
              //     // print('clicked');
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) =>
              //             FullImageScreen(figure: figure!, year:year)));
              //   },
              //   splashColor: Colors.white10,
              //   child: Image.asset(
              //     'assets/images/$year/${figure!.trim()}.PNG',
              //     scale: 3,
              //     fit: BoxFit.fill,
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
