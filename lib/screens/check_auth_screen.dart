import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/main_screen.dart';
import '../screens/user_profile.dart';

class CheckAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    Widget firstWidget;
    if (firebaseUser != null) {
      firstWidget = UserProfile();
    } else {
      firstWidget = MainScreen();
    }

    return Scaffold(body: firstWidget);
  }
}
