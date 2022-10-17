import 'dart:async';
import 'dart:io' show Platform;

import 'package:automotive_stats_invision/widgets/EngineStatusButton.dart';
import 'package:automotive_stats_invision/widgets/MainBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../config/constants/string_constant.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isConnected = false;
  bool isEngineStarted = false;
  double traveledDistance = 0.2;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff2c3036),
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: size.height * 0.05, horizontal: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isConnected
                      ? connectionStatusCONNECT
                      : connectionStatusFounded,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                  size: 15,
                  color: isConnected ? Color(0xff34c759) : Colors.red,
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            Container(
              margin: EdgeInsets.all(5),
              height: 56,
              width: 165,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(255, 255, 255, 0.3),
                    Color.fromRGBO(0, 0, 0, 0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                border: Border.all(
                    width: 1.5,
                    color: Color(0xff989a9d),
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.power_settings_new,
                    color: isEngineStarted ? Color(0xff25CB55) : Colors.red,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Engine Started",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.625,
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.03, 0, 0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 255, 255, 0.1),
                      Color.fromRGBO(0, 0, 0, 0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border.all(
                      width: 1.5,
                      color: Color(0xff989a9d),
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.425,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              CircularPercentIndicator(
                                radius: 70.0,
                                lineWidth: 20.0,
                                percent: traveledDistance,
                                center: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "2km",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      'Remaining',
                                      style: TextStyle(
                                          fontSize: 9, color: Colors.white),
                                    )
                                  ],
                                ),
                                // progressColor: Colors.green,
                                rotateLinearGradient: true,
                                linearGradient: LinearGradient(colors: const [
                                  Color(0xff428b04),
                                  Color(0xffc4770d),
                                ]),
                                startAngle: 180,
                                backgroundColor: Colors.transparent,
                              ),
                              Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Color(0xffd8d8d9),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Column(
                                  children: const [
                                    Text(
                                      'Target Distance',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '5KM',
                                      style: TextStyle(
                                          color: Colors.black38,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            // width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Image.asset(
                              'assets/images/car.png',
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: imgList.asMap().entries.map((entry) {
                    //     return GestureDetector(
                    //       onTap: () {
                    //         controller.animateToPage(entry.key);
                    //       },
                    //       child: Container(
                    //         width: 8.0,
                    //         height: 8.0,
                    //         margin:
                    //             EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    //         decoration: BoxDecoration(
                    //             shape: BoxShape.circle,
                    //             color: (Theme.of(context).brightness == Brightness.dark
                    //                     ? Colors.white
                    //                     : Colors.black)
                    //                 .withOpacity(current == entry.key ? 0.9 : 0.4)),
                    //       ),
                    //     );
                    //   }).toList(),
                    // ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
