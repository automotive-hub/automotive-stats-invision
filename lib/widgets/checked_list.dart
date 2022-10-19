import 'dart:async';

import 'package:flutter/material.dart';

import '../core/check_list/check_list_model.dart';
import '../models/checklist.dart';
import '../utils/const_string.dart';

class CheckedList extends StatefulWidget {
  final Map<CheckListName, StreamController<Check>> checkLists;
  const CheckedList({Key? key, required this.checkLists}) : super(key: key);

  @override
  State<CheckedList> createState() => _CheckedListState();
}

class _CheckedListState extends State<CheckedList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        itemExtent: 100,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        // itemCount: widget.checkLists.length,
        children: widget.checkLists.entries.map((value) {
          return StreamBuilder(
              stream: value.value.stream,
              builder: (context, snapshot) {
                print(snapshot.data);
                return _itemCheckList(snapshot.data ??
                    Check(name: 'xxxx', status: CheckListStatus.processing));
              });
        }).toList());
  }
}

Widget _itemCheckList(Check item) {
  Color listTileColor;
  Icon listTileIcon;
  String title = item.name;
  if (item.status == CheckListStatus.failed) {
    listTileColor = Color(0xfffb0049);
    listTileIcon = Icon(
      Icons.close,
      color: Colors.white,
    );
  } else if (item.status == CheckListStatus.processing) {
    listTileColor = Color(0xff4700B1);
    listTileIcon = Icon(
      Icons.more_horiz,
      color: Colors.white,
    );
    title = ConstString.loading;
  } else {
    listTileColor = Color(0xff53a93f);
    listTileIcon = Icon(
      Icons.check,
      color: Colors.white,
    );
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
