import 'package:flutter/material.dart';

class HeroLogo extends StatelessWidget {
  HeroLogo({required this.imgHeight});
  final double imgHeight;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logo',
      child: Container(
        height: imgHeight,
        child: Image.asset('images/bekron.png'),
      ),
    );
  }
}
