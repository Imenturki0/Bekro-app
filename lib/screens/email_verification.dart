import 'dart:async';
import 'package:bekron_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import '../components/hero_logo.dart';
import 'package:cool_alert/cool_alert.dart';
import '../screens/login_screen.dart';
import '../screens/user_profile.dart';

class EmailVerification extends StatefulWidget {
  static String id = 'verify_screen';
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool isEmailVerified=false;
  Timer? timer;

  Future sendVerificationEmail({showSuccess=false}) async {
    try{
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      if(showSuccess){
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: 'Verification link was successfully sent',
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    }
    catch(e){
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Failed',
        text: e.toString(),
        loopAnimation: false,
      );
      //signOut();
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified= FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isEmailVerified) timer?.cancel();
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.id,
        ModalRoute.withName('$EmailVerification.id'));
  }

  @override
  void initState() {
    super.initState();
    isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified){
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3), (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose(){
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if(isEmailVerified==true){
      return const UserProfile();
    }
    else{
      return Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Flexible(child: HeroLogo(imgHeight: 100.0),),
              const SizedBox(height: 25.0,),
              const Text(
                'A VERIFICATION LINK\n HAS BEEN SENT TO YOUR EMAIL!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 13.0, color: mainAppColor),
              ),
              const SizedBox(height: 13.0),
              RoundedButton(
                borderRadius: 15.0,
                textBtn: 'Re-Send The Link?',
                onPress: () {sendVerificationEmail(showSuccess:true);},
              ),
              const SizedBox(height: 5.0),
              GestureDetector(
                onTap: () {signOut();},
                child: const Text(
                  'Sign In with different Email',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13.0),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
