
import 'package:flutter/material.dart';

class EngineStatusButton extends StatefulWidget {
  final Color color;
  const EngineStatusButton({Key? key, required this.color}) : super(key: key);

  @override
  State<EngineStatusButton> createState() => _EngineStatusButtonState();
}

class _EngineStatusButtonState extends State<EngineStatusButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 56,
      width: 165,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(255, 255, 255, 0.3),
            Color.fromRGBO(0, 0, 0, 0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.all(
            width: 1.5,
            color: Color(0xff989a9d),
            style: BorderStyle.solid),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.power_settings_new,
            color:  widget.color,
          ),
          SizedBox(width: 5,),
          Text(
            "Engine Started",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
