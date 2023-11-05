import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:foodly/models/menu.dart';
import 'package:foodly/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../models/shop.dart';
import '../routes/routed.dart';
import '../uttils/Dimensions.dart';
import '../uttils/colors.dart';
import '../widgets/app_icon.dart';
import '../widgets/big_text.dart';

class RecommendFoodDetail extends StatefulWidget {
  final int i;

  const RecommendFoodDetail({required this.i, super.key});

  @override
  State<RecommendFoodDetail> createState() => _RecommendFoodDetailState();
}

class _RecommendFoodDetailState extends State<RecommendFoodDetail> {
  int quantity = 1;
  //decremnet
  void decrement() {
    setState(() {
      if (quantity > 1) {
        quantity -= 1;
      }
    });
  }

  void increment() {
    setState(() {
      if (quantity >= 20 ) {
        Get.snackbar(
            'Quantity Alert',
            'You can not increase no more!',
            snackPosition: SnackPosition.TOP,
            isDismissible: true,
            duration: Duration(seconds: 1),
            backgroundColor: AppColors.mainColor,
            colorText: Colors.white,
          );
        quantity = 20;
      } else {
        quantity += 1;
      }
    });
  }

  void addToCart() {
    if (quantity > 0) {
      final shop = context.read<Shop>();

      shop.addToCart(0, quantity);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                
                backgroundColor: AppColors.mainColor,
                content: const Text(
                  "Successfully added to cart",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);

                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.done)),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final longtext =
        "galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsumis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsumis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsumis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum";
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(icon: Icons.clear)),
              GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getCart());
                  },
                  child: AppIcon(icon: Icons.shopping_cart_outlined))
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Container(
              child: Center(
                child: BigText(
                  text: "tbs ethiopian",
                  size: Dimensions.font20,
                ),
              ),
              width: double.maxFinite,
              padding: EdgeInsets.only(top: 5, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  )),
            ),
          ),
          pinned: true,
          backgroundColor: AppColors.mainColor,
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              "assets/images/f_0.png",
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width30,
                    right: Dimensions.width30),
                child: ExpandableText(
                  longtext,
                  style: TextStyle(height: 2),
                  expandText: 'show more',
                  collapseText: 'show less',
                  maxLines: 5,
                  linkColor: AppColors.mainColor,
                ),
              )
            ],
          ),
        ),
      ]),
      bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          padding: EdgeInsets.only(
              top: Dimensions.height10,
              bottom: Dimensions.height10,
              left: Dimensions.width30 * 2.5,
              right: Dimensions.width30 * 2.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  decrement();
                  // controller.setQuantity(false);
                },
                child: AppIcon(
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    icon: Icons.remove),
              ),
              BigText(
                size: Dimensions.font26,
                text: "\$12.88 " + " X " + " ${quantity}",
                color: Colors.black,
              ),
              GestureDetector(
                onTap: () {
                  increment();
                },
                child: AppIcon(
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    icon: Icons.add),
              ),
            ],
          ),
        ),
        Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(
              top: Dimensions.height10,
              bottom: Dimensions.height10,
              left: Dimensions.width30,
              right: Dimensions.width30),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width30,
                  right: Dimensions.width30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
              ),
              child: Icon(
                Icons.favorite_outline,
                color: AppColors.mainColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                addToCart();
                // controller.addItem();
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width30,
                    right: Dimensions.width30),
                child: BigText(
                  text: "\$10 | Add to cart",
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor,
                ),
              ),
            )
          ]),
        ),
      ]),
    );
  }
}
