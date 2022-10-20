import 'package:automotive_stats_invision/core/ble_repository.dart';
import 'package:automotive_stats_invision/core/check_list/check_list_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterReactiveBle().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Provider(
      lazy: false,
      create: (BuildContext context) {
        return CheckListCore()
          ..createCheckListStore()
          ..start();
      },
      child: Provider(
        create: (context) => BleRepository(
            ble: FlutterReactiveBle(),
            checkListCore: context.read<CheckListCore>()),
        lazy: false,
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Poppins',
          ),
          home: const Home(),
        ),
      ),
    );
  }
}
