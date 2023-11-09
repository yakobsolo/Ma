import 'package:flutter/foundation.dart';
import 'package:foodly/pages/newCartPage.dart';
import 'package:foodly/pages/splash_screen.dart';
import 'package:foodly/restaurant_page.dart';
import 'package:get/get.dart';

import '../models/menu.dart';
import '../pages/cartPage.dart';
import '../pages/detailsPage.dart';

class RouteHelper {
  static const String splash = "/splash";
  static const String initial = "/";
  static const String foodDetail = "/details";
  static const String cartPage = "/cart";

  

  // late  Menu temp;
  static getCart() => "$cartPage";
  static getInitial() => "$initial";
  String getFoodDetail() => "$foodDetail";

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(
        name: cartPage, page: () => CartPageNew(), transition: Transition.fadeIn),
    GetPage(
        name: initial,
        page: () => RestaurantPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: foodDetail,
        page: () => RecommendFoodDetail(
              i: 0,
            ),
        transition: Transition.fadeIn),
  ];
}
