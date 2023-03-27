import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/bottom_nav_call.dart';
import '../components/contact_form.dart';
import '../components/hero_logo.dart';
import '../components/map.dart';
import '../constants.dart';
import 'package:flutter/services.dart';
import '../screens/user_profile.dart';
import '../screens/comming_soon.dart';
//import '../components/app_bar.dart';

class TalkToUs extends StatefulWidget {
  static String id = 'talk_to_us';

  const TalkToUs({super.key});

  @override
  State<TalkToUs> createState() => _TalkToUsState();
}

class _TalkToUsState extends State<TalkToUs> {
  late String nameSurname;
  late String mail;
  MapController mapController = MapController();
  LatLng currentCenter = LatLng(40.96832277164155, 29.063709644177774);
  double currentZoom = 13.5;

  @override
  void initState() {
    super.initState();
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                const HeroLogo(imgHeight: 70.0),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    const Text(
                                      'Work hours',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: mainAppColor),
                                      child: const Text('MON-SUNDAY 10-22'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          'Location',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              Uri phoneno = Uri.parse(
                                                  'https://goo.gl/maps/exch5j65hyypWFHh8');
                                              if (await launchUrl(phoneno)) {
                                                await launchUrl(phoneno);
                                              } else {
                                                throw 'Could not launch $phoneno';
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                backgroundColor: mainAppColor),
                                            child: const Text('Google maps'),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            Uri phoneno = Uri.parse(
                                                'https://yandex.com.tr/harita/106124/kadikoy/house/caddebostan_plajyolu_sok_8b/ZkAYdgFjQUcEQFpqfXV3eX5nZA==/?ll=29.063823%2C40.968240&z=16.47');
                                            if (await launchUrl(phoneno)) {
                                              await launchUrl(phoneno);
                                            } else {
                                              throw 'Could not launch $phoneno';
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              backgroundColor: mainAppColor),
                                          child: const Text('Yandex maps'),
                                        )
                                      ],
                                    ),
                                    Map(
                                        mapController: mapController,
                                        currentCenter: currentCenter,
                                        currentZoom: currentZoom)
                                  ],
                                ),
                                ContactForm(),
                              ],
                            ),
                          ],
                        ),
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
                  widget3: const Icon(Icons.arrow_back),
                  function3: () {
                    Navigator.pushNamed(context, UserProfile.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String text;
  final int maxlines;
  const InputField(this.text, this.maxlines, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          hintText: text,
        ),
        maxLines: maxlines,
      ),
    );
  }
}
