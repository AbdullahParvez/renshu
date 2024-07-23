import 'package:flutter/material.dart';

import '../screens/full_image_screen.dart';

class ImageBottomSheet extends StatelessWidget {
  const ImageBottomSheet({
    super.key,
    required this.height,
    required this.imageUrl,
    required this.year,
  });

  final double height;
  final String imageUrl;
  final String year;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: InkWell(
              onDoubleTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        FullImageScreen(figure: 'last_one', year: year),
                  ),
                );
              },
              splashColor: Colors.white10,
              child: Image.asset(
                imageUrl,
                scale: 2,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}