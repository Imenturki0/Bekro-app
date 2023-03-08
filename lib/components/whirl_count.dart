import 'package:flutter/material.dart';
import '../constants.dart';

class WhirlCount extends StatefulWidget {
  const WhirlCount({Key? key}) : super(key: key);
  static String id = 'whirl_screen';

  @override
  State<WhirlCount> createState() => _WhirlCountState();
}

class _WhirlCountState extends State<WhirlCount> {
  final List<String> items = [
    'images/coffee-bag.png',
    'images/coffee-bag.png',
    'images/coffee-bag.png',
    'images/coffee-bag.png',
    'images/coffee-bag.png',
    'images/coffee-bag.png',
    'images/coffee-bag.png',
    'images/coffee-bag.png',
    'images/coffee-bag.png',
    'images/coffee-bag.png',
    'images/coffee-bag.png',
    'images/coffee-bag.png',
    'images/coffee-bag.png',
  ];
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
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 4.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    items[index],
                    width: 40,
                    height: 40,
                  );
                },
              ),
            ),
            Flexible(
              flex: 2,
              child: Image.network(
                'https://picsum.photos/100',
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class WhirlIconWidget extends StatelessWidget {
//   static String id = 'whirl_screen';
//   final int whirlCount;
//
//   WhirlIconWidget({required this.whirlCount});
//
//   @override
//    Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Wrap(
//           alignment: WrapAlignment.start,
//         children: List.generate(
//         whirlCount,
//             (index) => Padding(
//          padding: EdgeInsets.only(right: 10, bottom: 10),
//          child: Image.asset(
//           'images/paper-cup.png',
//            width: 24,
//            height: 24,
//            ),
//          ),
//          ),
//         spacing: 4,
//          runSpacing: 4,
//           ),
//          SizedBox(width: 8),
//         Image.asset(
//     'images/star.png',
//      width: 24,
//     height: 24,
//         )
//       ],
//     );
//
//   }
//
//  }