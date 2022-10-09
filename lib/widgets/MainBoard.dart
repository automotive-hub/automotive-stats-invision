import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

final List<List<bool>> imgList = [
  [
    false,
    false,
    true,
    true,
  ],
  [
    true,
    true,
    true,
    true,
  ],
];
final List<Widget> imageSliders = imgList
    .map((item) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: item
              .map((e) => Column(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: e ? Color(0xff53a93f):Color(0xfffb0049),
                          child: Icon(
                        e ? Icons.check : Icons.close,size: 30,
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        e ? "Success" : "Fail",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  ))
              .toList(),
        ))
    .toList();

class MainBoard extends StatefulWidget {
  const MainBoard({Key? key}) : super(key: key);

  @override
  State<MainBoard> createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  final CarouselController controller = CarouselController();
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.65,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(255, 255, 255, 0.1),
              Color.fromRGBO(0, 0, 0, 0),
              Color.fromRGBO(255, 255, 255, 0.1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(
              width: 1.5, color: Color(0xff989a9d), style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 15.0,
                        percent: 0.75,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "2km",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'Remaining',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            )
                          ],
                        ),
                        // progressColor: Colors.green,
                        rotateLinearGradient: true,
                        linearGradient: LinearGradient(colors: const [
                          Color(0xff428b04),
                          Color(0xffc4770d),
                        ]),
                        startAngle: 180,
                        backgroundColor: Colors.transparent,
                      ),
                      Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Color(0xffd8d8d9),
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        child: Column(
                          children: const [
                            Text(
                              'Target Distance',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '5KM',
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.asset(
                      'assets/images/car.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 50,),
            CarouselSlider(
              items: imageSliders,
              carouselController: controller,
              options: CarouselOptions(
                  aspectRatio: 5,
                  height: 80,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      current = index;
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    controller.animateToPage(entry.key);
                  },
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ],
        ));
  }
}
