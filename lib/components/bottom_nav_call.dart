import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required this.widget1,
    required this.widget2,
    required this.widget3,
    required this.function3,
    required this.function2,
  });
  final Widget widget1;
  final Widget widget2;
  final Widget widget3;
  final VoidCallback function2;
  final VoidCallback function3;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    Uri phoneno = Uri.parse('tel:+905522720337');
                    if (await launchUrl(phoneno)) {
                      await launchUrl(phoneno);
                    } else {
                      throw 'Could not launch $phoneno';
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: mainAppColor),
                  child: widget1,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  onPressed: function2,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: mainAppColor),
                  child: widget2,
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: function3,
                style: ElevatedButton.styleFrom(backgroundColor: mainAppColor),
                child: widget3,
              ),
            ),
          ]),
    );
  }
}
