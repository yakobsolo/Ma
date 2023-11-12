// import 'package:foodly/bloc/product_bloc/product_bloc_bloc.dart';
// import 'package:foodly/restaurant_page.dart';
// import 'package:get/get.dart';

// import '../models/menu.dart';
// import '../pages/cartPage.dart';
// import '../pages/detailsPage.dart';

// class RouteHelper {
//   static const String initial = "/";
//   static const String foodDetail = "/details";
//   static const String cartPage = "/cart";

//   // late  Menu temp;
//   static getCart() => "$cartPage";
//   static getInitial() => "$initial";
//   String getFoodDetail() => "$foodDetail";

//   static final ProductBlocBloc pb = ProductBlocBloc();

//   static List<GetPage> routes = [
//     GetPage(
//         name: cartPage, page: () => CartPage(), transition: Transition.fadeIn),
//     // GetPage(
//     //     name: initial,
//     //     page: () => RestaurantPage(),
//     //     transition: Transition.fadeIn),
//     GetPage(
//         name: foodDetail,
//         page: () => RecommendFoodDetail(
//               i: 0,
//             ),
//         transition: Transition.fadeIn),
//   ];
// }
