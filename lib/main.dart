import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import '../screens/admin_control_panel.dart';
import '../screens/user_scan.dart';
import '../screens/login_screen.dart';
import '../screens/registration_screen.dart';
import '../screens/main_screen.dart';
import '../screens/forget_screen.dart';
import '../screens/launch_screen.dart';
import '../screens/admin_scan_qr.dart';
import '../screens/user_profile.dart';
import '../screens/email_verification.dart';
import '../screens/talk_to_us.dart';
import '../screens/comming_soon.dart';
import '../constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const BekronApp(),
  );
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
        LaunchScreen.id: (context) => const LaunchScreen(),
        MainScreen.id: (context) => const MainScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ForgotPassword.id: (context) => const ForgotPassword(),
        EmailVerification.id: (context) => const EmailVerification(),
        CommingSoon.id: (context) => const CommingSoon(),
        UserProfile.id: (context) => const UserProfile(),
        UserScan.id: (context) => UserScan(),
        AdminScanQr.id: (context) => const AdminScanQr(),
        AdminControlPanel.id: (context) => const AdminControlPanel(),
        TalkToUs.id: (context) => const TalkToUs(),
      },
    );
  }
}
