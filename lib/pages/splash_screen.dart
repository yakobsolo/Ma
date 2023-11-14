import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maleda/pages/onboarding_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
      body: Column(
        children: [
          Expanded(
            child: AnimatedSplashScreen(
              backgroundColor: Colors.white,
              splash: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "MALEDA",
                    style: TextStyle(
                        color: Colors.orange,
                        fontFamily: 'Money Honey',
                        fontWeight: FontWeight.bold,
                        fontSize: font26 * 1.7),
                  ),
                  Icon(
                    CupertinoIcons.shopping_cart,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  // Text(".", style: TextStyle( fontSize: font26, color: Colors.orange),)
                ],
              ),
              nextScreen: OnboardingPage(),
              splashTransition: SplashTransition.slideTransition,
              duration: 7000,
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(20), // Adjust the padding as needed
            child: Text(
              "Powered by NAY....",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
