import 'package:flutter/material.dart';
import '../constants.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.borderRadius,
      required this.textBtn,
      required this.onPress,
      this.btnWidth = 160,
      this.btnHeight = 39});

  final double borderRadius;
  final VoidCallback onPress;
  final String textBtn;
  final double btnWidth;
  final double btnHeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.0),
      child: Material(
        elevation: 5.0,
        color: mainAppColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: btnWidth,
          height: btnHeight,
          child: Text(
            textBtn,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
