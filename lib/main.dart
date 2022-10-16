import 'dart:async';

import 'package:automotive_stats_invision/check_list_service.dart/check_list_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import 'screens/main_screen.dart';

void main() async {
  CheckListService checkListService = CheckListService();

  checkListService.createCheckListStore();

  CheckList checkListInstance = checkListService.checkListStore["8a40e28c-e92a-4406-874e-4f71a21f69db"]!;
  checkListInstance.dataStream.listen((data){
    print(data);
    print(checkListInstance.store);
    //print(checkListInstance.dataStream.length);
  });

  runApp(const MyApp());

  while(true){
    await Future.delayed(Duration(seconds: 10));
    checkListService.addCheckListData("8a40e28c-e92a-4406-874e-4f71a21f69db", "test");
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
