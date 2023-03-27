import 'package:bekron_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CupComponent extends StatelessWidget {
  const CupComponent({
    super.key,
    required this.cupCount,
  });
  final double cupCount;

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        animationEnabled: false,
        customColors: CustomSliderColors(progressBarColor: mainAppColor),
        customWidths: CustomSliderWidths(progressBarWidth: 10),
      ),
      min: 0,
      max: 10,
      initialValue: cupCount,
      innerWidget: (whirlsCount) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Hero(
                          tag: 'logo',
                          child: SizedBox(
                            height: 50.0,
                            child: Image.asset('images/paper-cup.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    "$whirlsCount / 10",
                    style: const TextStyle(
                      color: mainAppColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
