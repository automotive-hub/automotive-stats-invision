import 'package:flutter/material.dart';

import '../utils/const_color.dart';
import '../utils/const_string.dart';

class StatusConnect extends StatefulWidget {
  final bool isConnected;
  const StatusConnect({Key? key, required this.isConnected}) : super(key: key);

  @override
  State<StatusConnect> createState() => _StatusConnectState();
}

class _StatusConnectState extends State<StatusConnect> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.isConnected ? ConstString.connected : ConstString.disconnected,
          style: TextStyle(fontSize: 30, color: ConstColor.whiteText),
        ),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.circle,
          size: 15,
          color: widget.isConnected ? ConstColor.success : ConstColor.fail,
        )
      ],
    );
  }
}
