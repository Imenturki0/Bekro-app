//import 'package:firebase_core/firebase_core.dart';
import '../screens/admin_control_panel.dart';
import '../screens/user_profile.dart';
import '../screens/user_scan.dart';
import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/registration_screen.dart';
import '../screens/main_screen.dart';
import '../screens/forget_screen.dart';
import '../screens/launch_screen.dart';
import '../screens/admin_scan_qr.dart';
import '../constants.dart';
import '../screens/talk_to_us.dart';

import 'components/whirl_count.dart';

void main() async {
  runApp(const BekronApp());
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
