import 'package:flutter/material.dart';

import '../models/checklist.dart';
import '../utils/const_string.dart';

class CheckedList extends StatefulWidget {
  final List<CheckListItem> itemsCheckList;
  const CheckedList({Key? key, required this.itemsCheckList}) : super(key: key);

  @override
  State<CheckedList> createState() => _CheckedListState();
}

class _CheckedListState extends State<CheckedList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemExtent: 100,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.itemsCheckList.length,
        itemBuilder: (context, index) {
          return _itemCheckList(widget.itemsCheckList[index]);
        });
  }

  Widget _itemCheckList(CheckListItem item) {
    Color listTileColor;
    Icon listTileIcon;
    String title = item.title;
    if (item.status == ItemCheckListStatus.fail) {
      listTileColor = Color(0xfffb0049);
      listTileIcon = Icon(
        Icons.close,
        color: Colors.white,
      );
    } else if (item.status == ItemCheckListStatus.loading) {
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
}
