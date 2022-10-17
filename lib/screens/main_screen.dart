import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bool _isConnected = false;
  final bool _isEngineStarted = false;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff2c3036),
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: screenSize.height * 0.05,
            horizontal: screenSize.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isConnected ? "Connected" : "Disconnected",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                  size: 15,
                  color: _isConnected ? Color(0xff34c759) : Colors.red,
                )
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.025,
            ),
            // EngineStatusButton(
            //   color: _isEngineStarted ? Color(0xff25CB55) : Colors.red,
            // ),

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
                    color: _isEngineStarted ? Color(0xff25CB55) : Colors.red,
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
              height: screenSize.height * 0.05,
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
                                percent: 0.2,
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
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
