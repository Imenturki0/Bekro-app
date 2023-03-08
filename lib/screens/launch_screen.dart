import 'package:flutter/material.dart';
import '../screens/main_screen.dart';
import 'dart:math';

class LaunchScreen extends StatefulWidget {
  static String id = 'launch_screen';

  const LaunchScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(milliseconds: 5000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
  }

  Widget build(BuildContext context) {
    Random random = Random();
    int launchImageIndex = random.nextInt(3);

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/launch-img-$launchImageIndex.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
