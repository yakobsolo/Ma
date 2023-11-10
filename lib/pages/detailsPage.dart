import 'dart:convert';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maleda/models/menu.dart';
import 'package:maleda/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../models/shop.dart';
import '../routes/routed.dart';
import '../uttils/colors.dart';
import '../widgets/app_icon.dart';
import '../widgets/big_text.dart';

class RecommendFoodDetail extends StatefulWidget {
  final Menu item;

  const RecommendFoodDetail({required this.item, super.key});

  @override
  State<RecommendFoodDetail> createState() => _RecommendFoodDetailState();
}

class _RecommendFoodDetailState extends State<RecommendFoodDetail> {
  int quantity = 1;
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> addToCart() async {
    // print(widget.item);
    var new_menu = {
      "title": widget.item.title,
      "description": widget.item.description,
      "image": widget.item.image,
      "price": widget.item.price,
      "qtyLeft": widget.item.qtyLeft,
      "itemPrice": (widget.item.price * quantity),
      "quantitiy": quantity,
    };
    if (quantity > 0) {
      var jsonData = await storage.read(key: 'carts');

      if (jsonData != null) {
        var jsonList = json.decode(jsonData);
        for (var value in jsonList) {
          if (new_menu['title'] == value['title']) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      // Icon color
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Already Added to cart!',
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                duration: Duration(seconds: 3),
              ),
            );
            return;
          }
        }
        jsonList.add(new_menu);
        final jsonString = json.encode(jsonList);
        await storage.write(key: 'carts', value: jsonString);
      } else {
        final jsonList = [new_menu];
        final jsonString = json.encode(jsonList);
        await storage.write(key: "carts", value: jsonString);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Row(
            children: <Widget>[
              Icon(
                Icons.check_circle,
                color: Colors.white,
                // Icon color
              ),
              SizedBox(width: 10),
              Text(
                'Added to cart!',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 14,
                ),
              ),
            ],
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item.qtyLeft < 1) {
      quantity = 0;
    }
    final longtext =
        "Galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsumis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsumis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsumis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum";

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double width30 = screenWidth / 21.1;

    double height10 = screenHeight / 84.4;
    double height20 = screenHeight / 42.2;

    double font26 = screenHeight / 29.48;

    double radius20 = screenHeight / 42.2;

    double bottomHeightBar = screenHeight / 7.03;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    // Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.clear,
                    iconColor: Colors.white,
                    backgroundColor: Colors.orange,
                  )),
              GestureDetector(
                  onTap: () {
                    // Get.toNamed(RouteHelper.getCart());
                  },
                  child: AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: Colors.white,
                    backgroundColor: Colors.orange,
                  ))
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Container(
              child: Center(
                child: Text(
                  widget.item.title,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              width: double.maxFinite,
              padding: EdgeInsets.only(top: 5, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius20),
                    topRight: Radius.circular(radius20),
                  )),
            ),
          ),
          pinned: true,
          backgroundColor: Colors.orange,
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              "https://maleda-backend.onrender.com/${widget.item.image}",
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
                    top: height20, left: width30, right: width30),
                child: ExpandableText(
                  longtext,
                  style: TextStyle(
                    height: 2,
                    color: Colors.grey,
                  ),
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
              top: height10,
              bottom: height10,
              left: width30 * 2.5,
              right: width30 * 2.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (quantity < 1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Row(
                            children: <Widget>[
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                // Icon color
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Minimum quantity reached!',
                                style: TextStyle(
                                  color: Colors.white, // Text color
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    } else {
                      quantity -= 1;
                    }
                  });
                },
                child: AppIcon(
                    iconColor: Colors.white,
                    backgroundColor: Colors.orange,
                    icon: Icons.remove),
              ),
              BigText(
                size: font26,
                text: "${widget.item.price}" + "x" + " ${quantity}",
                color: Colors.orange,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    print(quantity);
                    if (quantity >= widget.item.qtyLeft.toInt()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Row(
                            children: <Widget>[
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                // Icon color
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Maximum quantity reached!',
                                style: TextStyle(
                                  color: Colors.white, // Text color
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    } else {
                      quantity += 1;
                    }
                  });
                },
                child: AppIcon(
                    iconColor: Colors.white,
                    backgroundColor: Colors.orange,
                    icon: Icons.add),
              ),
            ],
          ),
        ),
        Container(
          height: bottomHeightBar,
          padding: EdgeInsets.only(
              top: height10, bottom: height10, left: width30, right: width30),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radius20 * 2),
                  topRight: Radius.circular(radius20 * 2))),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: () async {
                await addToCart();
                print("written");
                // controller.addItem();
              },
              child: Container(
                padding: EdgeInsets.only(
                  top: height20,
                  bottom: height20,
                  left: width30,
                  right: width30,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    BigText(
                      text: "Add to cart",
                      color: Colors.white,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius20),
                  color: Colors.orange,
                ),
              ),
            )
          ]),
        ),
      ]),
    );
  }
}
