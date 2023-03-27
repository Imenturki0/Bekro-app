import 'package:flutter/material.dart';
import '../constants.dart';
import '../components/app_bar.dart';
import '../components/hero_logo.dart';
import '../screens/user_profile.dart';

class CommingSoon extends StatefulWidget {
  static String id = 'coming_soon';
  const CommingSoon({super.key});

  @override
  State<CommingSoon> createState() => _CommingSoonState();
}

class _CommingSoonState extends State<CommingSoon> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: MainAppBar(
            backButton: true,
            onPress: () {
              Navigator.pushNamed(context, UserProfile.id);
            }),
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Flexible(
                  child: HeroLogo(imgHeight: 100.0),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  'COMING SOON',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: mainAppColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
