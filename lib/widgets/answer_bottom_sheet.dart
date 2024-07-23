import 'package:flutter/material.dart';

class AnswerBottomSheet extends StatelessWidget {
  const AnswerBottomSheet({
    super.key,
    required this.height,
    required this.answer,
    required this.selectedAnswer,
    required this.explanation,
  });

  final double height;
  final int answer;
  final int selectedAnswer;
  final String explanation;

  Widget checkAnswer() {
    if (answer == selectedAnswer) {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.done_outline,
            color: Colors.green,
            size: 40,
          ),
          SizedBox(width: 10), // Add spacing between icon and text
          Text(
            'Correct',
            style: TextStyle(fontSize: 30),
          ),
        ],
      );
    } else {
      return const Row(
        mainAxisAlignment:
            MainAxisAlignment.center, // Adjust alignment as needed
        children: [
          Icon(
            Icons.cancel_outlined,
            color: Colors.red,
            size: 40,
          ),
          SizedBox(width: 10), // Add spacing between icon and text
          Text('Wrong', style: TextStyle(fontSize: 30)),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.cyan[50],
          border: Border.all(
            color: (Colors.cyan[100])!,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          checkAnswer(),
          const SizedBox(
            height: 10,
          ),
          if (explanation != '')
            const Text('Explanation',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 6,
          ),
          Text(
            explanation,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
