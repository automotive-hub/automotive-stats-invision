import 'package:flutter/material.dart';

import '../models/check_list.dart';

class CheckList extends StatefulWidget {
  final CheckListValue checkList;

  const CheckList({Key? key, required this.checkList}) : super(key: key);

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  @override
  Widget build(BuildContext context) {
    Color? color;
    switch (widget.checkList.status) {
      case "Success":
        color = Color(0xff53a93f);
        break;
      case "Failed":
        color = Color(0xfffb0049);
        break;
      case "Processing":
        color = Color(0xff4700B1);
        break;
    }
    return Column(
      children: [
        CircleAvatar(
            radius: 25,
            backgroundColor: color,
            child: Icon(
              Icons.more_horiz,
              size: 30,
            )),
        SizedBox(
          height: 10,
        ),
        Text(
          widget.checkList.status,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
        )
      ],
    );
  }
}
