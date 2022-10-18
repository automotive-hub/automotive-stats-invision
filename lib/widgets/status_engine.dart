import 'package:flutter/material.dart';

import '../utils/const_color.dart';
import '../utils/const_string.dart';

class StatusEngine extends StatefulWidget {
  final bool isEngineStarted;
  const StatusEngine({Key? key, required this.isEngineStarted})
      : super(key: key);

  @override
  State<StatusEngine> createState() => _StatusEngineState();
}

class _StatusEngineState extends State<StatusEngine> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 56,
      width: 165,
      decoration: BoxDecoration(
        border: Border.all(
            width: 1.5, color: ConstColor.border, style: BorderStyle.solid),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.power_settings_new,
            color:
                widget.isEngineStarted ? ConstColor.success : ConstColor.fail,
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
    );
  }
}
