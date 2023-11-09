import 'package:flutter/material.dart';
import 'package:foodly/uttils/Dimensions.dart';
import 'package:foodly/widgets/big_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomPaint(
            painter: ArcPainter(),
            child: SizedBox(
              height: Dimensions.screenHeight / 1.4,
              width: Dimensions.screenWidth,
            ),
          )
        ],
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Path orangeArc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, Dimensions.screenHeight - 170)
      ..quadraticBezierTo(Dimensions.screenWidth/2,Dimensions.screenHeight, Dimensions.screenWidth, Dimensions.screenHeight - 170)
      ..lineTo(Dimensions.screenWidth, Dimensions.screenHeight)
      ..lineTo(Dimensions.screenWidth, 0)
      ..close();

    canvas.drawPath(orangeArc, Paint()..color = Colors.orange);
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

  OnboardingModel(this.lottieFile, this.subtitle, this.title);
}

List<OnboardingModel> tabs = [
  OnboardingModel('assets/a.json', 'fdjsl', 'fs'),
  OnboardingModel('assets/b.json', 'fsa', 'fasdf'),
  OnboardingModel('assets/c.json', 'fs', 'fasfs'),
];
