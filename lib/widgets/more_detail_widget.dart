import 'package:flutter/material.dart';

class MoreDetailWidget extends StatefulWidget {
  const MoreDetailWidget({Key? key}) : super(key: key);

  @override
  State<MoreDetailWidget> createState() => _MoreDetailWidgetState();
}

class _MoreDetailWidgetState extends State<MoreDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.21,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 25, left: 15, right: 15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(255, 255, 255, 0.4),
              Color.fromRGBO(0, 0, 0, 0.4),
            ],
            stops: [0, 0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(
            width: 0.5,
            color: Color.fromRGBO(255, 255, 255, 0.4),
          ),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        child: Column(
          children: [
            Text(
              "Title engine",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Content",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Tortor aliquet adipiscing",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(color: Color.fromRGBO(255, 255, 255, 0.4)),
            SizedBox(
              height: 5,
            ),
            Row(
              children: const [
                ImageIcon(
                  AssetImage("assets/images/exclude_icon.png"),
                  size: 24,
                  color: Color.fromRGBO(255, 255, 255, 0.4),
                ),
                SizedBox(width: 7,),
                Text(
                  "Status Log",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
