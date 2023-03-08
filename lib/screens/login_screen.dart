//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../components/rounded_button.dart';
import '../components/hero_logo.dart';
import '../components/start_pages_header.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../screens/forget_screen.dart';
import '../screens/registration_screen.dart';
import '../components/form_input.dart';
import 'package:regexed_validator/regexed_validator.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //final _auth = FirebaseAuth.instance ;
  late String emailorphone;
  late String password;
  bool showSpinner = false;

  final _formKey = GlobalKey<FormState>();
  String? validateInputs(String? value, String inputType) {
    if (value == null || value.isEmpty) {
      return "* Required";
    } else if (inputType == 'mailphone' &&
        !validator.email(value) &&
        !validator.phone(value)) {
      return 'Please enter a valid email or phone';
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
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
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
                    StartPagesHeader(mainText: 'LOGIN INTO YOUR ACCOUNT'),
                    FormInput(
                      hintText: 'Email or Phone Number',
                      validatorFunction: (value) =>
                          validateInputs(value, 'mailphone'),
                      onChangedFunction: (value) {
                        emailorphone = value;
                      },
                    ),
                    FormInput(
                      hintText: 'Password',
                      validatorFunction: (value) =>
                          validateInputs(value, 'password'),
                      obsecure: true,
                      onChangedFunction: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(height: 3.0),
                    RoundedButton(
                      borderRadius: 15.0,
                      textBtn: 'LogIn',
                      onPress: () async {
                        if (_formKey.currentState!.validate()) {
                          //Implement login functionality.
                          /*setState(() {showSpinner = true;});
                        try{
                          final isLoggedinUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                          if(isLoggedinUser != null){
                            Navigator.pushNamed(context, ChatScreen.id);
                          }
                          setState(() {showSpinner = false;});
                        }catch(e){print(e);}*/
                        }
                      },
                    ),
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ForgotPassword.id);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13.0),
                      ),
                    ),
                    SizedBox(height: 7.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'Don\'t have an account? '),
                            TextSpan(
                                text: 'SIGN UP',
                                style: TextStyle(color: mainAppColor)),
                          ],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.0),
                        ),
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
