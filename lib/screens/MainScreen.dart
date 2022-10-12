import 'package:automotive_stats_invision/widgets/EngineStatusButton.dart';
import 'package:automotive_stats_invision/widgets/MainBoard.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff2c3036),
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: size.height * 0.05, horizontal: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Vehicle Connected  ',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                Icon(
                  Icons.circle,
                  size: 15,
                  color: Color(0xff34c759),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            EngineStatusButton(),
            SizedBox(
              height: size.height * 0.05,
            ),
            MainBoard(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
