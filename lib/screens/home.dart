import 'package:automotive_stats_invision/utils/const_string.dart';
import 'package:automotive_stats_invision/widgets/checked_list.dart';
import 'package:automotive_stats_invision/widgets/circle_percent_remain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';

import '../core/ble_repository.dart';
import '../models/checklist.dart';
import '../utils/const_color.dart';
import '../widgets/status_connect.dart';
import '../widgets/status_engine.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final bool _isConnected = false;
  final bool _isEngineStarted = false;
  final double _percentIndicatorValue = 0.2;
  final int _targetDistance = 5;
  final List<CheckListItem> _itemsCheckList = [
    CheckListItem(
        logs: 'Log success',
        status: ItemCheckListStatus.success,
        title: ConstString.overHeat),
    CheckListItem(
        logs: 'Log success',
        status: ItemCheckListStatus.fail,
        title: ConstString.testRun),
    CheckListItem(
        logs: 'Log success',
        status: ItemCheckListStatus.success,
        title: ConstString.engineLight),
    CheckListItem(
        logs: 'Log success',
        status: ItemCheckListStatus.loading,
        title: ConstString.deletedCode),
  ];

  @override
  initState() {
    super.initState();
    // bleStreams.deviceConnectionState.stream.listen((event) {
    //   print(event);
    //   if (event.connectionState == DeviceConnectionState.connected) {
    //     bleStreams.getListStream(event.deviceId);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final ble = context.read<BleRepository>();
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
            StatusConnect(
              isConnected: _isConnected,
            ),
            SizedBox(
              height: screenSize.height * 0.025,
            ),
            GestureDetector(
              onTap: () async {
                await ble.connectToOBD();
              },
              child: StreamBuilder<DeviceConnectionState>(
                  stream: ble.deviceConnectionState.stream,
                  builder: (context, snapshot) {
                    var isDeviceConnected = false;
                    if (snapshot.data == DeviceConnectionState.connected) {
                      isDeviceConnected = true;
                    }
                    return StatusEngine(
                      isEngineStarted: isDeviceConnected,
                    );
                  }),
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
                    CirclePercentRemain(
                      percentIndicatorValue: _percentIndicatorValue,
                      targetDistance: _targetDistance,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Expanded(
                        child: CheckedList(
                      itemsCheckList: _itemsCheckList,
                    ))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
