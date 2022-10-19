import 'package:automotive_stats_invision/config/constants/ble_desgin_constants.g.dart';
import 'package:automotive_stats_invision/core/check_list/check_list_core.dart';
import 'package:automotive_stats_invision/core/check_list/check_list_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../utils/const_color.dart';
import '../utils/const_string.dart';
import '../utils/debug_dialog.dart';

class CirclePercentRemain extends StatefulWidget {
  final double percentIndicatorValue;
  final int targetDistance;
  const CirclePercentRemain(
      {Key? key,
      required this.percentIndicatorValue,
      required this.targetDistance})
      : super(key: key);

  @override
  State<CirclePercentRemain> createState() => _CirclePercentRemainState();
}

class _CirclePercentRemainState extends State<CirclePercentRemain> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.425,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              StreamBuilder<Check>(
                stream: context.read<CheckListCore>().checkList[CheckListName.distance.name]!.stream,
                builder: (context, snapshot) {
                  Check distanceCheck = snapshot.data ?? Check(name: CheckListName.distance.name, value: 0);
                  int distanceBase = 5;
                  double percent = distanceCheck.value / distanceBase;

                  return CircularPercentIndicator(
                    radius: 70.0,
                    lineWidth: 20.0,
                    percent: percent,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (distanceBase - distanceCheck.value).toString(),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: ConstColor.whiteText),
                        ),
                        Text(
                          ConstString.remaining,
                          style:
                              TextStyle(fontSize: 9, color: ConstColor.whiteText),
                        )
                      ],
                    ),
                    rotateLinearGradient: true,
                    linearGradient: ConstColor.colorFullGradient,
                    startAngle: 180,
                    backgroundColor: ConstColor.border.withOpacity(0.5),
                  );
                }
              ),
              Expanded(
                child: Center(
                  child: StreamBuilder<dynamic>(
                      stream: context
                          .read<CheckListCore>()
                          .dataRawStream[
                              BleOBDCheckList.engineLoadCharacteristic]!
                          .dataStream,
                      builder: (context, snapshot) {
                        var rpm = 0;
                        if (snapshot.hasData) {
                          rpm = snapshot.data;
                        }
                        return Text(
                          "$rpm RPM",
                          style: TextStyle(
                              fontSize: 25, color: ConstColor.whiteText),
                        );
                      }),
                ),
              ),
              InkWell(
                onTap: () {
                  CheckListCore checkListCore = context.read<CheckListCore>();
                  int lastData = checkListCore
                          .dataRawStream[BleOBDCheckList
                              .vehicleDistanceTraveledSinceCodesClearedCharacteristic]!
                          .store
                          .last ??
                      0;
                  lastData = lastData + 1;
                  checkListCore.addCheckListData(
                      BleOBDCheckList
                          .vehicleDistanceTraveledSinceCodesClearedCharacteristic,
                      lastData);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: ConstColor.whiteText,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
                        '${widget.targetDistance} Km',
                        style: TextStyle(
                            color: ConstColor.border,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          GestureDetector(
            onDoubleTap: () async => {await openDebugDialog(context)},
            child: Container(
              margin: const EdgeInsets.only(left: 15),
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.asset(
                'assets/images/car.png',
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
