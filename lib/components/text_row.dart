import 'package:flutter/material.dart';
import '../constants.dart';

class TextRow extends StatelessWidget {
  final String title;
  final String titleResult;
  final String imagePath;
  const TextRow(
      {required this.title,
        required this.titleResult,
        required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: kUserProfileText,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(titleResult, style: kUserProfileText),
        const SizedBox(
          width: 6,
        ),
        Image.asset(
          imagePath,
          width: 20,
          height: 20,
        ),
      ],
    );
  }
}