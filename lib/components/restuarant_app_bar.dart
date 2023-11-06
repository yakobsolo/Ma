import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodly/routes/routed.dart';
import 'package:foodly/widgets/app_icon.dart';
import 'package:get/get.dart';

class RestaurantAppBAr extends StatelessWidget {
  const RestaurantAppBAr({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.orange,
      pinned: true,
      expandedHeight: 340,
      backgroundColor: Colors.orange,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          "assets/images/Header-image.png",
          fit: BoxFit.cover,
        ),
      ),

      // leading: Padding(
      //   padding: EdgeInsets.only(left: 16),
      //   child: Icon(Icons.menu),
      // ),
      actions: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getCart());
          },
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
