import 'package:flutter/material.dart';
import 'dart:math';
import 'check_auth_screen.dart';

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
      context,
      MaterialPageRoute(
        builder: (context) => const CheckAuth(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int launchImageIndex = random.nextInt(3);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/launch-img-$launchImageIndex.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    children: [
                      const Spacer(),
                      const Text(
                        'Boost\nYour\nTaste',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 270.0,
                        width: 390.0,
                        child: Image.asset('./images/yatay.png'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
