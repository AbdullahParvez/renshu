import 'package:flutter/material.dart';

class FullImageScreen extends StatelessWidget {
  const FullImageScreen({super.key, required this.figure, required this.year});

  final String figure;
  final String year;
  @override
  Widget build(BuildContext context) {
    // print(imageUrl);
    return Scaffold(
      body: InteractiveViewer(
        panEnabled: true,
        minScale: 1,
        maxScale: 4,
        child: Image.asset(
          'assets/images/$year/$figure.PNG',
          // fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
