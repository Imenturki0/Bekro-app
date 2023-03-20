import '../components/whirl_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/rounded_button.dart';
import '../components/text_row.dart';
import '../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'admin_scan_qr.dart';
import '../models/helpers.dart';
import '../screens/main_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../screens/user_profile.dart';

class AdminControlPanel extends StatefulWidget {
  static String id = 'admin_panel_screen';
  const AdminControlPanel({Key? key}) : super(key: key);

  @override
  State<AdminControlPanel> createState() => _AdminControlPanelState();
}

class _AdminControlPanelState extends State<AdminControlPanel> {
  bool isLoggedIn = false;
  bool isAdmin = false;
  bool showScreen = false;

  late int used_cups_count;
  late int stars_count;

  int stars_in_view = 0;
  int rewards_cup_in_view = 0;
  int whirls_count = 0;
  int whirls_images = 0;
  int whirls_number = 0;
  String name = '';
  String email = '';
  List<String> items = [];
  String qrcode = '';
  int control = 0;
  //Map<String,dynamic> arguments = Map();
  void getData() async {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    qrcode = arguments['qrcode'];

    var result = await getUserDetail('qr_code', qrcode);
    print("starting..");
    print(result);

    setState(() {
      name = result['full_name'];
      email = result['email'];
      used_cups_count = result['used_cups_count'];
      stars_count = result['stars_count'];
      whirls_count = result['whirls_count'];
      stars_in_view = stars_count - used_cups_count * 10;
      rewards_cup_in_view = (stars_count / 10 - used_cups_count).toInt();
      whirls_images = whirls_count % 13;
      whirls_number = (whirls_count / 13).toInt();
      items = List.filled(whirls_images, 'images/coffee-bag.png');
    });
    print(used_cups_count);
    print(stars_count);
    print(stars_in_view);
    print(rewards_cup_in_view);

    print("get data");
  }

  void addStar() async {
    var doc_id;
    var result;
    await newCollection.where('qr_code', isEqualTo: qrcode).get().then((user) {
      if (user.size != 0) {
        doc_id = user.docs.first.id;
        newCollection
            .doc(doc_id)
            .update({"stars_count": stars_count + 1}).then((value) async {
          print("sssssssssssssssssss");
          result = await getUserDetail('qr_code', qrcode);
          setState(() {
            used_cups_count = result['used_cups_count'];
            stars_count = result['stars_count'];
            stars_in_view = stars_count - used_cups_count * 10;
            rewards_cup_in_view = (stars_count / 10 - used_cups_count).toInt();
          });
        });
      }
    });
  }

  void oneUse() async {
    var doc_id;
    var result;
    await newCollection.where('qr_code', isEqualTo: qrcode).get().then((user) {
      if (user != null) {
        doc_id = user.docs.first.id;
        if (stars_count >= (used_cups_count + 1) * 10) {
          newCollection.doc(doc_id).update(
              {'used_cups_count': used_cups_count + 1}).then((value) async {
            result = await getUserDetail('qr_code', qrcode);
            setState(() {
              used_cups_count = result['used_cups_count'];
              stars_count = result['stars_count'];
              stars_in_view = stars_count - used_cups_count * 10;
              rewards_cup_in_view =
                  (stars_count / 10 - used_cups_count).toInt();
            });
          });
        }
        print("sssssssssssssssssss");
        print(stars_in_view);
      }
    });
  }

  void addWhirl() async {
    var doc_id;
    var result;
    await newCollection.where('qr_code', isEqualTo: qrcode).get().then((user) {
      if (user != null) {
        doc_id = user.docs.first.id;

        newCollection
            .doc(doc_id)
            .update({'whirls_count': whirls_count + 1}).then((value) async {
          result = await getUserDetail('qr_code', qrcode);
          setState(() {
            whirls_count = result['whirls_count'];
            whirls_images = whirls_count % 13;
            whirls_number = (whirls_count / 13).toInt();
            items = List.filled(whirls_images, 'images/coffee-bag.png');
          });
        });

        print("sssssssssssssssssss");
        print(stars_in_view);
      }
    });
  }

  void UseWhirl() async {
    var doc_id;
    var result;
    await newCollection.where('qr_code', isEqualTo: qrcode).get().then((user) {
      if (user != null) {
        doc_id = user.docs.first.id;
        if ((whirls_count - 13) / 13.toInt() >= 0) {
          newCollection
              .doc(doc_id)
              .update({'whirls_count': whirls_count - 13}).then((value) async {
            result = await getUserDetail('qr_code', qrcode);
            setState(() {
              whirls_count = result['whirls_count'];
              whirls_images = whirls_count % 13;
              whirls_number = (whirls_count / 13).toInt();
              items = List.filled(whirls_images, 'images/coffee-bag.png');
            });
          });
        }
        print(whirls_count);
      }
    });
  }

  final newCollection = FirebaseFirestore.instance.collection('Clients');
  //String name = 'AHMET MADENOĞULLAR';
  //String email = 'ahmet@gmail.com';

  void getUserType() async {
    isLoggedIn = isUserLogged();
    if (isLoggedIn) {
      isAdmin = await isUserAdmin();
      if (isAdmin) {
        getData();
        print("yes");
      }
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
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
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
    if (showScreen && isLoggedIn && !isAdmin) {
      return const UserProfile();
    } else if (showScreen && !isLoggedIn) {
      return const MainScreen();
    } else if (showScreen && isLoggedIn && isAdmin) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: kUserAdminText,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          email,
                          style: kUserAdminEmailText,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 7.0),
                          child: Material(
                            elevation: 5.0,
                            color: mainAppColor,
                            borderRadius: BorderRadius.circular(10),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AdminScanQr.id);
                              },
                              minWidth: 140,
                              height: 49.0,
                              child: Row(
                                children: const [
                                  Text(
                                    'back',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          child: RoundedButton(
                              borderRadius: 10,
                              textBtn: '1*',
                              onPress: () {

                                addStar();
                              },
                              btnWidth: 100,
                              btnHeight: 50.0),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          child: RoundedButton(
                              borderRadius: 10,
                              textBtn: '10*',
                              onPress: () {
                                oneUse();
                              },
                              btnWidth: 100,
                              btnHeight: 50.0),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('Cup Component'),
                        Image.asset(
                          'images/star.png',
                          width: 20,
                          height: 20,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        TextRow(
                          title: "Reward drink",
                          titleResult: rewards_cup_in_view.toString(),
                          imagePath: 'images/paper-cup.png',
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextRow(
                          title: "Star balance",
                          titleResult: stars_in_view.toString(),
                          imagePath: 'images/star.png',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 8,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: TextRow(
                                title: "Whirl",
                                titleResult: whirls_number.toString(),
                                imagePath: 'images/coffee-bag.png',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: WhirlCount(
                                  whirls_image: whirls_images, items: items),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 25.0, left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RoundedButton(
                                  borderRadius: 10,
                                  textBtn: 'Add Whirl',
                                  onPress: () {
                                    addWhirl();
                                  },
                                  btnHeight: 49.0,
                                ),
                                RoundedButton(
                                  borderRadius: 10,
                                  textBtn: 'Use Whirl',
                                  onPress: () {
                                    UseWhirl();
                                  },
                                  btnHeight: 49.0,
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
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
