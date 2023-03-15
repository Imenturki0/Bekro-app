import 'package:bekron_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/helpers.dart';
import '../screens/main_screen.dart';
import '../screens/user_profile.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    Widget firstWidget;
    if (firebaseUser != null) {
      firstWidget = RegistrationScreen();
    } else {
      firstWidget = MainScreen();
    }
    return Scaffold(body: firstWidget);
  }
}
