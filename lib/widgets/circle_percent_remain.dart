import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
              CircularPercentIndicator(
                radius: 70.0,
                lineWidth: 20.0,
                percent: widget.percentIndicatorValue,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (widget.percentIndicatorValue * 100).toStringAsFixed(0),
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
              ),
              Spacer(),
              Container(
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
