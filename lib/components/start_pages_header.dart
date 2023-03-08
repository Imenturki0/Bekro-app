import 'package:flutter/material.dart';
import '../constants.dart';

class StartPagesHeader extends StatelessWidget {
  StartPagesHeader({required this.mainText});
  final String mainText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sizeBoxWidth,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 15.0),
        child: Text(
          '$mainText',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
