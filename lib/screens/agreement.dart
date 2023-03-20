import 'package:flutter/material.dart';
import '../screens/registration_screen.dart';
import '../screens/email_verification.dart';
import '../components/rounded_button.dart';
import '../components/hero_logo.dart';
import '../components/agreement_text.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cool_alert/cool_alert.dart';

import '../models/helpers.dart';

class AgreementScreen extends StatefulWidget {

  const AgreementScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.password});
  final String name;
  final String email;
  final String password;

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  bool showSpinner = false;
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _openMyPage(String pageId) {
    Navigator.pushNamedAndRemoveUntil(
        context,
        pageId,
        ModalRoute.withName('$RegistrationScreen.id'));
  }

  void _openAlert(String title, String text, CoolAlertType alerType) {
    CoolAlert.show(
      context: context,
      type: alerType,
      title: title,
      text: text,
      loopAnimation: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Expanded(
                flex: 1,
                child: HeroLogo(imgHeight: 90.0),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                flex: 9,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      margin: const EdgeInsets.fromLTRB(6, 6, 6, 20),
                      padding: const EdgeInsets.fromLTRB(16, 26, 0, 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFFEEEFEF),
                      ),
                      child: Column(
                        children: const <Widget>[
                          Expanded(
                            child: SingleChildScrollView(
                                padding: EdgeInsets.only(right: 22),
                                scrollDirection: Axis.vertical,
                                child: agreementText),
                          ),
                        ],
                      ),
                    ),
                    RoundedButton(
                      borderRadius: 15.0,
                      textBtn: 'I have read and I approve',
                      onPress: () async {
                        setState(() {showSpinner = true;});
                        try {
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: widget.email,
                            password: widget.password,
                          );
                          setState(() {showSpinner = false;});
                          User? updateUser = FirebaseAuth.instance.currentUser;
                          updateUser?.updateDisplayName(widget.name);

                          await userSetup(widget.name);
                          _openMyPage(EmailVerification.id);

                        }on FirebaseAuthException catch (e) {
                          setState(() {showSpinner = false;});
                          _openAlert('Failed',e.toString(), CoolAlertType.error);
                        } catch (e) {
                          setState(() {showSpinner = false;});
                          _openAlert('Failed',e.toString(), CoolAlertType.error);
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
