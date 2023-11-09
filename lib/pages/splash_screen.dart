import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:foodly/pages/onboarding_page.dart';
import 'package:foodly/restaurant_page.dart';
import 'package:foodly/routes/routed.dart';
import 'package:foodly/uttils/colors.dart';
import 'package:foodly/widgets/big_text.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: AppColors.mainColor,
        splash: Icon(Icons.home, color: Colors.white,size: 64,), nextScreen: OnboardingPage(),
        splashTransition: SplashTransition.rotationTransition,
        duration: 3000,

        );
  }
}
