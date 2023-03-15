import '../components/whirl_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/rounded_button.dart';
import '../components/text_row.dart';
import '../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'admin_scan_qr.dart';

class AdminControlPanel extends StatefulWidget {
  static String id = 'admin_panel_screen';
  const AdminControlPanel({Key? key}) : super(key: key);

  @override
  State<AdminControlPanel> createState() => _AdminControlPanelState();
}

class _AdminControlPanelState extends State<AdminControlPanel> {
  late int used_cups_count;
  late int stars_count;
  int stars_in_view = 0;
  int rewards_cup_in_view = 0;
  void getData() async {
    // DocumentSnapshot document = await FirebaseFirestore.instance.collection('users').document(uid).get();

    await newCollection.doc('id').get().then((document) {
      used_cups_count = document.data()!["used_cups_count"];
      stars_count = document.data()!["stars_count"];
    });
    stars_in_view = stars_count - used_cups_count * 10;
    rewards_cup_in_view = (stars_count / 10 - used_cups_count).toInt();
    print(stars_in_view);
    print(rewards_cup_in_view);
    print("get data");
  }

  void addStar() async {
//if(stars_in_view+1%10==0) {
    await newCollection
        .doc("id")
        .update({
          "stars_count": stars_count + 1,
        })
        .then((value) => {})
        .catchError((error) => print(error));
  }

  void oneUse() async {
    await newCollection
        .doc("id")
        .update({
          "used_cups_count": used_cups_count + 1,
        })
        .then((value) => print("done"))
        .catchError((error) => print(error));
  }

  final newCollection = FirebaseFirestore.instance.collection('Clients');
  String name = 'AHMET MADENOĞULLAR';
  String email = 'ahmet@gmail.com';
  @override
  void initState() {
    super.initState();
    getData();
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
                              getData();
                              setState(() {
                                stars_in_view =
                                    (stars_count + 1) - used_cups_count * 10;
                                rewards_cup_in_view =
                                    ((stars_count + 1) / 10 - used_cups_count)
                                        .toInt();
                                print(rewards_cup_in_view);
                                print(stars_in_view);
                              });
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
                              getData();
                              oneUse();
                              setState(() {
                                setState(() {
                                  stars_in_view =
                                      (stars_count - 10) - used_cups_count * 10;
                                  rewards_cup_in_view =
                                      ((stars_count - 10) / 10 -
                                              used_cups_count)
                                          .toInt();
                                  print(rewards_cup_in_view);
                                  print(stars_in_view);
                                });
                              });
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
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: TextRow(
                              title: "Whirl",
                              titleResult: '0',
                              imagePath: 'images/coffee-bag.png',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: WhirlCount(),
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
                                onPress: () {},
                                btnHeight: 49.0,
                              ),
                              RoundedButton(
                                borderRadius: 10,
                                textBtn: 'Use Whirl',
                                onPress: () {},
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
  }
}
