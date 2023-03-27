import 'package:flutter/material.dart';

class HeroLogo extends StatelessWidget {
  const HeroLogo({super.key, required this.imgHeight});
  final double imgHeight;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logo',
      child: SizedBox(
        height: imgHeight,
        child: Image.asset('images/bekron.png'),
      ),
    );
  }
}
