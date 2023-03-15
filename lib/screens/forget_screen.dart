import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import '../components/hero_logo.dart';
import '../components/start_pages_header.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/form_input.dart';
import 'package:regexed_validator/regexed_validator.dart';
// import 'package:cool_alert/cool_alert.dart';
import '../screens/login_screen.dart';

class ForgotPassword extends StatefulWidget {
  static String id = 'forgot_screen';
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late String email;
  bool showSpinner = false;

  final _formKey = GlobalKey<FormState>();
  String? validateInputs(String? value) {
    if (value == null || value.isEmpty) {
      return "* Required";
    } else if (!validator.email(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: 400.0,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: HeroLogo(imgHeight: 100.0),
                    ),
                    StartPagesHeader(mainText: 'FORGOT YOUR PASSWORD?'),
                    FormInput(
                      hintText: 'Email',
                      validatorFunction: (value) => validateInputs(value),
                      onChangedFunction: (value) {
                        email = value;
                      },
                    ),
                    const SizedBox(height: 3.0),
                    RoundedButton(
                      borderRadius: 15.0,
                      textBtn: 'SEND RESET LINK',
                      onPress: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {showSpinner = true;});
                          try {
                            await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                            setState(() {showSpinner = false;});
                            // CoolAlert.show(
                            //   context: context,
                            //   type: CoolAlertType.success,
                            //   text: 'Password reset sent to your email',
                            //   autoCloseDuration: const Duration(seconds: 2),
                            // );
                            await Future.delayed(const Duration(milliseconds: 3500), () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  LoginScreen.id,
                                  ModalRoute.withName('$ForgotPassword.id'));
                            });
                          } catch (e) {
                            setState(() {showSpinner = false;});
                            // CoolAlert.show(
                            //   context: context,
                            //   type: CoolAlertType.error,
                            //   title: 'Failed',
                            //   text: 'There is no user record corresponding to this identifier',
                            //   loopAnimation: false,
                            // );
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 5.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: const Text(
                        'Go to Log In page',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
