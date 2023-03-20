import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

class BottomNav extends StatelessWidget {
  BottomNav(this.widget1, this.widget2, this.widget3);
  final Widget widget1;
  final Widget widget2;
  final Widget widget3;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
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
                  style: ElevatedButton.styleFrom(backgroundColor: mainAppColor),
                  child: widget1,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  onPressed: () async {
                      Uri phoneno = Uri.parse('https://www.google.com/');
                      if (await launchUrl(phoneno)) {
                        await launchUrl(phoneno);
                      } else {
                        throw 'Could not launch $phoneno';
                      }
                    },
                  style: ElevatedButton.styleFrom(backgroundColor: mainAppColor),
                  child: widget2,
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: mainAppColor),
                child: widget3,
              ),
            ),
          ]),
    );
  }
}
