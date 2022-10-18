import 'package:automotive_stats_invision/utils/const_string.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../utils/const_color.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bool _isConnected = false;
  final bool _isEngineStarted = false;
  final ItemCheckListStatus _itemCheckListStatus = ItemCheckListStatus.loading;
  final double _percentIndicatorValue = 0.2;
  final int _targetDistance = 5;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstColor.background,
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
                  _isConnected
                      ? ConstString.connected
                      : ConstString.disconnected,
                  style: TextStyle(fontSize: 30, color: ConstColor.whiteText),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                  size: 15,
                  color: _isConnected ? ConstColor.success : ConstColor.fail,
                )
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.025,
            ),
            Container(
              margin: EdgeInsets.all(5),
              height: 56,
              width: 165,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1.5,
                    color: ConstColor.border,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.power_settings_new,
                    color:
                        _isEngineStarted ? ConstColor.success : ConstColor.fail,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    ConstString.engineStart,
                    style: TextStyle(
                      color: ConstColor.whiteText,
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
                  gradient: ConstColor.greyGradient,
                  border: Border.all(
                      width: 1.5,
                      color: ConstColor.border,
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
                                percent: _percentIndicatorValue,
                                center: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      (_percentIndicatorValue * 100)
                                          .toStringAsFixed(0),
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: ConstColor.whiteText),
                                    ),
                                    Text(
                                      ConstString.remaining,
                                      style: TextStyle(
                                          fontSize: 9,
                                          color: ConstColor.whiteText),
                                    )
                                  ],
                                ),
                                rotateLinearGradient: true,
                                linearGradient: ConstColor.colorFullGradient,
                                startAngle: 180,
                                backgroundColor:
                                    ConstColor.border.withOpacity(0.5),
                              ),
                              Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: ConstColor.whiteText,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      ConstString.targetDistance,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '$_targetDistance Km',
                                      style: TextStyle(
                                          color: ConstColor.border,
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
                    Expanded(
                        child: ListView.builder(
                            itemExtent: 100,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return _itemCheckList(_itemCheckListStatus);
                            }))
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _itemCheckList(ItemCheckListStatus itemCheckListStatus) {
    Color listTileColor;
    Icon listTileIcon;
    String title;
    if (itemCheckListStatus == ItemCheckListStatus.fail) {
      listTileColor = Color(0xfffb0049);
      listTileIcon = Icon(
        Icons.close,
        color: Colors.white,
      );
      title = 'Fail';
    } else if (itemCheckListStatus == ItemCheckListStatus.loading) {
      listTileColor = Color(0xff4700B1);
      listTileIcon = Icon(
        Icons.more_horiz,
        color: Colors.white,
      );
      title = 'Loading';
    } else {
      listTileColor = Color(0xff53a93f);
      listTileIcon = Icon(
        Icons.check,
        color: Colors.white,
      );
      title = 'Successful';
    }
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: listTileColor,
          child: listTileIcon,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
        )
      ],
    );
  }
}

enum ItemCheckListStatus { loading, success, fail }
