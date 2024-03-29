import 'package:flutter/material.dart';
import '../constants.dart';

class StartPagesHeader extends StatelessWidget {
  const StartPagesHeader({super.key, required this.mainText});
  final String mainText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sizeBoxWidth,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 15.0),
        child: Text(
          mainText,
          style: const TextStyle(
            fontSize: 15.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
