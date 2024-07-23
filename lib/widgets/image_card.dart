import 'package:flutter/material.dart';
import 'package:renshu/screens/full_image_screen.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.figure, required this.year});

  final String figure;
  final String year;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Align(
        alignment: Alignment.center,
        child: InkWell(
          onDoubleTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FullImageScreen(
                  figure: figure,
                  year: year,
                ),
              ),
            );
          },
          splashColor: Colors.white10,
          child: Image.asset(
            'assets/images/$year/$figure.PNG',
            scale: 2,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
