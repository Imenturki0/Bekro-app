import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/services.dart';
import 'main_screen.dart';
import 'admin_scan_qr.dart';
import 'talk_to_us.dart';
import '../screens/comming_soon.dart';
import '../components/cup_component.dart';
import '../components/whirl_count.dart';
import '../components/hero_logo.dart';
import '../components/rounded_button.dart';
import '../components/text_row.dart';
import '../components/bottom_nav_call.dart';
import '../models/helpers.dart';
import '../constants.dart';
//import '../components/app_bar.dart';

class UserProfile extends StatefulWidget {
  static String id = 'user_profile';
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isLoggedIn = false;
  bool isAdmin = false;
  bool showScreen = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  String qrData = '';
  late Map<String, dynamic> userData = {};
  late String fullName;
  late String userIdRef = '';
  int whirlCount = 0;
  int whirls_number = 0;
  int stars_in_view = 0;
  int rewards_cup_in_view = 0;
  int cupCount = 0;
  User? firebaseUser = FirebaseAuth.instance.currentUser;

  Future<dynamic> getData() async {
    final userInfo = await getUserData(firebaseUser!.uid);
    if (userInfo.isNotEmpty) {
      setState(() {
        userData = userInfo;
        qrData = userData['qr_code'];
        whirlCount = userData['whirls_count'] % 13;
        whirls_number = (userData['whirls_count'] / 13).toInt();
        stars_in_view =
            userData['stars_count'] - userData['used_cups_count'] * 10;
        rewards_cup_in_view =
            (userData['stars_count'] / 10 - userData['used_cups_count'])
                .toInt();
        cupCount = userData['stars_count'] % 10;
      });
      print(userData['stars_count']);
      print(userData['used_cups_count']);
    }
  }

  void getUserType() async {
    isLoggedIn = isUserLogged();
    if (isLoggedIn) {
      isAdmin = await isUserAdmin();
      getData();
    }
    setState(() {
      showScreen = true;
    });
  }

  @override
  void initState() {
    super.initState();
    if (!showScreen) {
      getUserType();
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (showScreen && isLoggedIn && isAdmin) {
      return const AdminScanQr();
    } else if (showScreen && !isLoggedIn) {
      return const MainScreen();
    } else if (showScreen && isLoggedIn && !isAdmin) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: SafeArea(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      child: SizedBox(
                        height: double.infinity,
                        width: 600,
                        child: SingleChildScrollView(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Clients')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final users = snapshot.data?.docs;

                                  for (var user in users!) {
                                    if (user.get('uid').toString() ==
                                        firebaseUser!.uid.toString()) {
                                      final messageText = user.get('uid');

                                      qrData = user.get('qr_code');
                                      whirlCount =
                                          user.get('whirls_count') % 13;
                                      whirls_number =
                                          (user.get('whirls_count') / 13)
                                              .toInt();
                                      stars_in_view = user
                                              .get('stars_count') -
                                          user.get('used_cups_count') * 10;
                                      rewards_cup_in_view =
                                          (user.get('stars_count') / 10 -
                                              user
                                                      .get('used_cups_count'))
                                              .toInt();
                                      cupCount =
                                          user.get('stars_count') % 10;
                                    }
                                  }
                                } else {
                                  print("none ");
                                }

                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Center(
                                      child: HeroLogo(imgHeight: 70.0),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ' ${userData['email'] ?? ''} ',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        Material(
                                          type: MaterialType.transparency,
                                          child: Ink(
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(500.0),
                                              onTap: () async {
                                                await FirebaseAuth.instance
                                                    .signOut();
                                                Navigator.pushNamed(
                                                    context, MainScreen.id);
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    30, 10, 0, 10),
                                                child: Icon(
                                                  Icons.logout,
                                                  color: mainAppColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Center(
                                      child: CupComponent(
                                        cupCount: cupCount.toDouble() ?? 0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, bottom: 35.0),
                                      child: Center(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextRow(
                                              title: "Reward drink",
                                              imagePath: 'images/paper-cup.png',
                                              titleResult:
                                                  '${rewards_cup_in_view ?? '0'} ',
                                            ),
                                            TextRow(
                                              title: "Star balance",
                                              titleResult:
                                                  ' ${stars_in_view ?? '0'} ',
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
                                          String stars =
                                              ' ${stars_in_view ?? '0'} ';
                                          String cups =
                                              '${rewards_cup_in_view ?? '0'} ';
                                          _showFullModal(
                                              context, qrData, stars, cups);
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, bottom: 20.0),
                                      child: TextRow(
                                        title: "Whirl",
                                        titleResult: '${whirls_number ?? '0'} ',
                                        imagePath: 'images/coffee-bag.png',
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: WhirlCount(whirlsNum: whirlCount),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                    ),
                  ),
                  BottomNav(
                    widget1: const Text("CALL"),
                    widget2: const Text("WEBSITE"),
                    function2: () {
                      Navigator.pushNamed(context, CommingSoon.id);
                    },
                    widget3: const Text("TALK TO US"),
                    function3: () {
                      Navigator.pushNamed(context, TalkToUs.id);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: true,
          child: SizedBox(),
        ),
      );
    }
  }
}

dynamic _showFullModal(context, String data, String starNum, String cupNum) {
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
                  //Navigator.pop(context);
                  Navigator.pushNamed(context, UserProfile.id);
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
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextCount(
                        titleResult: cupNum, imagePath: 'images/paper-cup.png'),
                    const SizedBox(
                      width: 32,
                    ),
                    TextCount(
                        titleResult: starNum, imagePath: 'images/star.png'),
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
  const TextCount(
      {super.key, required this.titleResult, required this.imagePath});

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
