import '../screens/admin_control_panel.dart';
import '../screens/user_profile.dart';
import '../screens/user_scan.dart';
import '../screens/login_screen.dart';
import '../screens/registration_screen.dart';
import '../screens/main_screen.dart';
import '../screens/forget_screen.dart';
import '../screens/launch_screen.dart';
import '../screens/admin_scan_qr.dart';
import '../constants.dart';
import '../screens/talk_to_us.dart';
import '../components/whirl_count.dart';

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     // options: DefaultFirebaseOptions.currentPlatform,
  //     );
  runApp(const BekronApp());
// final _firestore = FirebaseFirestore.instance;
// _firestore.collection('Users').add({
// 'email': 'test@gmail.com',
// 'phone_number': '9999',
// 'free_cups_count': 0,
// 'free_whirls_count': 0,
// 'full_name': "lobana",
// 'is_admin': true,
// 'is_client': false,
// 'password': "111111",
// 'qr_code': "test",
// 'stars_count': 7,
// 'used_cups_count': 0,
// 'used_whirls_count': 0,
// 'whirls_count': 27
// });
}

class BekronApp extends StatelessWidget {
  const BekronApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bekron App',
      home: const LaunchScreen(),
      theme: ThemeData(
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: mainAppColor),
      ),
      routes: {
        MainScreen.id: (context) => MainScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ForgotPassword.id: (context) => const ForgotPassword(),
        UserProfile.id: (context) => const UserProfile(),
        UserScan.id: (context) => UserScan(),
        WhirlCount.id: (context) => const WhirlCount(),
        AdminControlPanel.id: (context) => const AdminControlPanel(),
        LaunchScreen.id: (context) => const LaunchScreen(),
        TalkToUs.id: (context) => TalkToUs(),
        AdminScanQr.id: (context) => const AdminScanQr(),
      },
    );
  }
}
