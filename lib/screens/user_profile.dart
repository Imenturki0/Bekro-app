import 'package:firebase_auth/firebase_auth.dart';
import '../components/whirl_count.dart';
import 'package:flutter/material.dart';
import '../components/hero_logo.dart';
import 'package:barcode_widget/barcode_widget.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import '../models/helpers.dart';
import '../screens/main_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../screens/admin_scan_qr.dart';
import '../components/text_row.dart';

class UserProfile extends StatefulWidget {
  static String id = 'user_profile_screen';
  //final String userDocId;
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isLoggedIn=false;
  bool isAdmin=false;
  bool showScreen=false;
  FirebaseAuth auth = FirebaseAuth.instance;
  String qrData = '';
  late Map<String, dynamic> userData={};
  late String fullName;
  late String userIdRef = '';

  Future<dynamic> getData() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    final userInfo = await getUserData(firebaseUser!.uid);
    if (userInfo.isNotEmpty) {
      setState(() {
        userData = userInfo;
        qrData = userData['qr_code'];
      });
    }
  }

  void getUserType() async {
    isLoggedIn=isUserLogged();
    if(isLoggedIn){
      isAdmin = await isUserAdmin();
      getData();
    }
    setState(() {showScreen= true;});
  }

  @override
  void initState() {
    super.initState();
    if(!showScreen){getUserType();}
  }

  @override
  Widget build(BuildContext context) {
    if(showScreen && isLoggedIn && isAdmin){
      return const AdminScanQr();
    }
    else if(showScreen && !isLoggedIn){
      return const MainScreen();
    }
    else if(showScreen && isLoggedIn && !isAdmin){
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Center(child: HeroLogo(imgHeight: 70.0)),
              const SizedBox(
                height: 25,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(' ${userData['email'] ?? ''} ',
                      style: const TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      )),
                  RoundedButton(
                      borderRadius: 10,
                      textBtn: 'logout',
                      onPress: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, MainScreen.id);
                      }),
                ],
              ),
              const Expanded(
                child: Center(
                  child: Text('Cup Component',
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      )),
                ),
              ),
              // expanded
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextRow(
                        title: "Reward drink",
                        imagePath: 'images/paper-cup.png',
                        titleResult: '${userData['used_cups_count'] ?? '0'} ',
                      ),
                      TextRow(
                        title: "Star balance",
                        titleResult: ' ${userData['stars_count'] ?? '0'} ',
                        imagePath: 'images/star.png',
                      ),
                    ],
                  ),
                ),
              ),

              Center(
                child: RoundedButton(
                  borderRadius: 10.0,
                  textBtn: 'SCAN QR',
                  onPress: () {
                    _showFullModal(context, qrData);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextRow(
                    title: "Whirl",
                    titleResult: '${userData['whirls_count'] ?? '0'} ',
                    imagePath: 'images/coffee-bag.png'),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: WhirlCount(),
                ),
              ),
            ],
          ),
        ),
      );
    }
    else{
      return const Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: true,
          child: SizedBox(),
        ),
      );
    }
  }
}



dynamic _showFullModal(context, String data) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false, // should dialog be dismissed when tapped outside
    barrierLabel: "Modal", // label for barrier
    transitionDuration: const Duration(
        milliseconds:
            500), // how long it takes to popup dialog after button click
    pageBuilder: (_, __, ___) {
      // your widget implementation
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            elevation: 0.0),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: HeroLogo(imgHeight: 100.0),
              ),
              Center(
                  child: BarcodeWidget(
                data: data,
                barcode: Barcode.qrCode(),
                color: Colors.black87,
                height: 250,
                width: 250,
                margin: const EdgeInsets.only(top: 40),
              )),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    TextCount(
                        titleResult: '3', imagePath: 'images/paper-cup.png'),
                    SizedBox(
                      width: 32,
                    ),
                    TextCount(titleResult: '45', imagePath: 'images/star.png'),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

class TextCount extends StatelessWidget {
  final String titleResult;
  final String imagePath;
  const TextCount({required this.titleResult, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Text(titleResult, style: kUserScanText),
          const SizedBox(
            width: 16,
          ),
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
        ],
      ),
    );
  }
}
