import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currindex = 0;
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double width10 = screenWidth / 84.4;
    double width20 = screenWidth / 42.2;
    double width30 = screenWidth / 21.1;

    double height10 = screenHeight / 84.4;
    double height20 = screenHeight / 42.2;
    double height30 = screenHeight / 21.1;

    double font20 = screenHeight / 42.2;
    double font26 = screenHeight / 29.48;
    double radius10 = screenHeight / 84.4;
    double radius20 = screenHeight / 42.2;
    double radius30 = screenHeight / 21.1;

    // list view Size

    double listViewImgSize = screenWidth / 3.25;
    double listViewTextContSize = screenWidth / 3.9;

    //detail food

    double foodImageSize = screenHeight / 2.41;

    // icon Size

    double iconSize24 = screenHeight / 35.17;
    double iconSize16 = screenHeight / 52.75;

    // bottome height

    double bottomHeightBar = screenHeight / 7.03;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        children: [
          CustomPaint(
            painter: ArcPainter(context: context),
            child: SizedBox(
              height: screenHeight / 1.4,
              width: screenWidth,
            ),
          ),
          Positioned(
            top: 130,
            right: 5,
            left: 5,
            child: Lottie.asset(
              tabs[_currindex].lottieFile,
              key: Key('${Random().nextInt(999999999)}'),
              width: 600,
              alignment: Alignment.topCenter,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: screenHeight / 2 - 130,
              child: Column(
                children: [
                  Flexible(
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: tabs.length,
                        onPageChanged: (value) {
                          setState(() {
                            _currindex = value;
                          });
                        },
                        itemBuilder: (context, index) {
                          OnboardingModel tab = tabs[index];
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  tab.title,
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                // SizedBox(
                                //   height: height30,
                                // ),
                                Text(
                                  tab.subtitle,
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 17),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int index = 0; index < tabs.length; index++)
                        _DotIndicator(isSelected: index == _currindex),
                    ],
                  ),
                  SizedBox(
                    height: height30,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_currindex == 2) {
            final pref = await SharedPreferences.getInstance();
            pref.setBool('showHome', true);
            Navigator.of(context).pushNamed('/'); // chage it with bloc
            
          } else {
            pageController.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.linear);
          }
        },
        child: Icon(
          CupertinoIcons.chevron_right,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  final context;
  ArcPainter({required this.context});
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Path orangeArc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, screenHeight - 400)
      ..quadraticBezierTo(
          screenWidth / 2, screenHeight - 250, screenWidth, screenHeight - 400)
      ..lineTo(screenWidth, screenHeight)
      ..lineTo(screenWidth, 0)
      ..close();

    canvas.drawPath(orangeArc, Paint()..color = Colors.orange);

    Path whiteArc = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(0.0, screenHeight - 420)
      ..quadraticBezierTo(
          screenWidth / 2, screenHeight - 250, screenWidth, screenHeight - 500)
      ..lineTo(screenWidth, screenHeight)
      ..lineTo(screenWidth, 0)
      ..close();

    canvas.drawPath(whiteArc, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _DotIndicator extends StatelessWidget {
  final bool isSelected;
  const _DotIndicator({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 6.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 6.0,
        width: 6.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.white : Colors.white30,
        ),
      ),
    );
  }
}

class OnboardingModel {
  final String lottieFile;
  final String title;
  final String subtitle;

  OnboardingModel(this.lottieFile, this.title, this.subtitle);
}

List<OnboardingModel> tabs = [
  OnboardingModel('assets/images/fresh_on_time.json', 'Welcome to Maleda',
      'Step into Maleda\'s welcoming embrace,\n where the aromas of Ethiopia\'s \n rich culinary heritage beckon. '),
  OnboardingModel('assets/images/driver.json', 'Fast & Fresh Pickup',
      'Order ahead and collect \n your favorite Ethiopian dishes \n at your convenience.'),
  OnboardingModel('assets/images/order.json', 'Customize Your Feast',
      'Craft your perfect \n Ethiopian meal with a few taps.\n Explore a diverse menu, select your\n favorite dishes, and tailor your\n  order to suit your cravings.'),
];
