import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double width10 = screenWidth / 84.4;
  static double width20 = screenWidth / 42.2;
  static double width30 = screenWidth / 21.1;

  static double height10 = screenHeight / 84.4;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 21.1;

  static double font20 = screenHeight / 42.2;
  static double font26 = screenHeight / 29.48;
  static double radius10 = screenHeight / 84.4;
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 21.1;

  // list view Size

  static double listViewImgSize = screenWidth / 3.25;
  static double listViewTextContSize = screenWidth / 3.9;

  //detail food

  static double foodImageSize = screenHeight / 2.41;

  // icon Size

  static double iconSize24 = screenHeight / 35.17;
  static double iconSize16 = screenHeight / 52.75;

  // bottome height

  static double bottomHeightBar = screenHeight / 7.03;
}
