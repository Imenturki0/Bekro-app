import 'package:flutter/material.dart';
import '../constants.dart';

class WhirlCount extends StatefulWidget {
  const WhirlCount({Key? mykey, required this.whirlsNum}) : super(key: mykey);
  static String id = 'whirl_screen';

  final int whirlsNum;
  @override
  State<WhirlCount> createState() => _WhirlCountState();
}

class _WhirlCountState extends State<WhirlCount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: mainAppColor,
      ),
      child: IntrinsicWidth(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 6,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 13,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 4.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    index < widget.whirlsNum
                        ? 'images/coffee-bag.png'
                        : 'images/coffee-bag-gray.png',
                    width: 30,
                    height: 30,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
