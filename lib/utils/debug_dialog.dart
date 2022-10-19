import 'dart:async';

import 'package:automotive_stats_invision/config/constants/ble_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

Future<void> openDebugDialog(BuildContext context) async {
  final size = MediaQuery.of(context).size;

  return showDialog(
      context: context,
      builder: (builder) {
        return Dialog(
          child: Container(
              width: size.width * 0.9,
              height: size.height * 0.8,
              child: DebugDialog()),
        );
      });
}

class DebugDialog extends StatefulWidget {
  const DebugDialog({super.key});

  @override
  State<DebugDialog> createState() => _DebugDialogState();
}

class _DebugDialogState extends State<DebugDialog> {
  late BleRepository ble_repo;
  late StreamSubscription<OBDChecklist> streamSub;
  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    await streamSub.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ble_repo = context.read<BleRepository>();
    streamSub = ble_repo.obd2ReaderState.stream.listen((event) {
      obd2Items.add(event);
      setState(() {});
    });
  }

  final DateFormat formatter = DateFormat('hh:mm:ss');
  final List<OBDChecklist> obd2Items = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: obd2Items.length,
          itemBuilder: (context, index) {
            final data = String.fromCharCodes(this.obd2Items[index].data);
            final timeNow = formatter.format(DateTime.now());
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(timeNow),
                  Text("${obd2Items[index].type.name}:- [$data]"),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            );
          },
        ));
  }
}
