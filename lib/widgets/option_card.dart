import 'package:flutter/material.dart';
import 'package:renshu/widgets/image_and_text_card.dart';

import 'image_card.dart';
import 'text_only_card.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    super.key,
    required Size screen,
    required this.year,
    required this.option,
    required this.borderColor,
    required this.onSelectCard,
    required this.optionNo,
    required this.translation,
  }) : _screen = screen;

  final Size _screen;
  final int optionNo;
  final String option;
  final String translation;
  final String year;
  final Color? borderColor;
  final void Function(int cardNo) onSelectCard;

  Widget checkOptionHaveFigure(option) {
    if (option.contains('Picture')) {
      return ImageCard(
        figure: option,
        year: year,
      );
    } else if (option.contains('Figure')) {
      List<String> optionPart = option!.split('#');
      return ImageAndTextCard(
        figure: optionPart[0],
        text: optionPart[1],
        translation: translation,
        year: year,
      );
    } else {
      return TextOnlyCard(
        text: option,
        year: year,
        translation: translation,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor!,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      width: _screen.width * 0.48,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onTap: () {
                onSelectCard(optionNo);
              },
              child: checkOptionHaveFigure(option),
            ),
          ),
        ],
      ),
    );
  }
}
