import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

void main() {

  runApp(
   const LiquidSwipeApp(),
  );
}

///Class to hold data for itemBuilder.
class ItemData {
  final Color color;
  final String image;
  final String text1;
  final String text2;
  final String text3;

  ItemData(this.color, this.image, this.text1, this.text2, this.text3);
}

///the app class
class LiquidSwipeApp extends StatefulWidget {
  const LiquidSwipeApp({Key? key}) : super(key: key);

  @override
  _LiquidSwipeApp createState() => _LiquidSwipeApp();
}

class _LiquidSwipeApp extends State<LiquidSwipeApp> {
  int page = 0;
  late LiquidController liquidController;
  late UpdateType updateType;
   final style = const TextStyle(
    fontSize: 30,
    fontFamily: "Billy",
    fontWeight: FontWeight.w600,
  );

  List<ItemData> data = [
    ItemData(const Color(0xfffeca7f), "assets/image1.jpg", "Hello", "It's Effect", "Liquid Swipe"),
    ItemData(const Color(0xff702075), "assets/image2.jpg", "Take a", "Look At",
        "This is Love Fly"),
    ItemData(const Color(0xff4a664f), "assets/image3.jpg", "This is", "Kiss", "People Kissing"),
    ItemData(const Color(0xffab728b), "assets/image4.jpg", "Also Can be", "A book",
        "A Love Book"),
    ItemData(const Color(0xff0a260b), "assets/image5.jpg", "Yah  ", "A Tree", "Love Tree"),
  ];

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return  SizedBox(
      width: 25.0,
      child:  Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child:  SizedBox(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            LiquidSwipe.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  color: data[index].color,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        data[index].image,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            data[index].text1,
                            style: style,
                          ),
                          Text(
                            data[index].text2,
                            style: style,
                          ),
                          Text(
                            data[index].text3,
                            style: style,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              positionSlideIcon: 0.8,
              slideIconWidget: const Icon(Icons.arrow_back_ios),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              fullTransitionValue: 880,
              enableSideReveal: true,
              enableLoop: true,
              ignoreUserGestureWhileAnimating: true,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  const Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(data.length, _buildDot),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextButton(
                  onPressed: () {
                    liquidController.animateToPage(
                        page: data.length - 1, duration: 700);
                  },
                  child: const Text("Skip to End",
                    style: TextStyle(color: Colors.black87 ),),
                 // color: Colors.white.withOpacity(0.01),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextButton(
                  onPressed: () {
                    liquidController.jumpToPage(
                        page: liquidController.currentPage + 1 > data.length - 1
                            ? 0
                            : liquidController.currentPage + 1);
                  },
                  child: const Text("Next",
                  style: TextStyle(color: Colors.black87 ),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  pageChangeCallback(int lPage) {
    setState(() {
      page = lPage;
    });
  }
}
