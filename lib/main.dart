import 'package:automotive_stats_invision/core/ble_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await FlutterReactiveBle().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => BleRepository(ble: FlutterReactiveBle()),
      lazy: false,
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        home: const Home(),
      ),
    );
  }
}
