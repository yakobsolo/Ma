// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:maleda/pages/cartPage.dart';
import 'package:provider/provider.dart';

import 'package:maleda/models/menu.dart';
import 'package:maleda/widgets/small_text.dart';

import '../models/shop.dart';
import '../routes/routed.dart';
import '../uttils/colors.dart';
import '../widgets/app_icon.dart';
import '../widgets/big_text.dart';

class RecommendFoodDetail extends StatefulWidget {
  final Menu item;
  final int qty;

  const RecommendFoodDetail({
    Key? key,
    required this.item,
    required this.qty,
  }) : super(key: key);

  @override
  State<RecommendFoodDetail> createState() => _RecommendFoodDetailState();
}

class _RecommendFoodDetailState extends State<RecommendFoodDetail> {
  late int quantity = 1;
  static FlutterSecureStorage storage = const FlutterSecureStorage();
  late TextEditingController instruction;
  String? orderInstruction = "";
  bool found = false;

  @override
  void initState() {
    super.initState();
    instruction = TextEditingController();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   instruction.dispose();
  //   super.dispose();
  // }

  Future<String?> openDiag() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Enter you instruction",
            style: TextStyle(color: Colors.orange),
          ),
          content: TextField(
            controller: instruction,
            decoration:
                const InputDecoration(hintText: "Enter your instruction here"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(instruction.text);
              },
              child: const Text("Submit"),
            )
          ],
        ),
      );

  Future<void> addToCart() async {
    String? desc = await openDiag();
    setState(() {
      orderInstruction = desc;
    });

    final jsonString = await storage.read(key: 'carts');
    if (jsonString != null) {
      final jsonData = json.decode(jsonString);
      // print(quantity);
      for (int i = 0; i < jsonData.length; ++i) {
        if (jsonData[i]['title'] == widget.item.title &&
            jsonData[i]['instruction'] == orderInstruction) {
          if (jsonData[i]['quantity'] + quantity > widget.item.qtyLeft) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
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
                      "Maximum reached for this product",
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

          int before = 0;

          for (int i = 0; i < jsonData.length; ++i) {
            if (jsonData[i]['title'] == widget.item.title) {
              int cnt = jsonData[i]["quantity"];
              before += cnt;
            }
          }

          if (before + quantity > widget.item.qtyLeft) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
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
                      "Maximum reached for this product",
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

          jsonData[i]['quantity'] = jsonData[i]['quantity'] + quantity;
          jsonData[i]['subTotal'] += jsonData[i]['price'];
          final insertedData = json.encode(jsonData);
          await storage.write(key: "carts", value: insertedData);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
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
                    'Cart Added Successfully',
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

      int before = 0;

      for (int i = 0; i < jsonData.length; ++i) {
        if (jsonData[i]['title'] == widget.item.title) {
          int cnt = jsonData[i]["quantity"];
          before += cnt;
        }
      }

      if (before + quantity > widget.item.qtyLeft) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
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
                  "Maximum reached for this product",
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
      final newMenu = {
        "id": widget.item.id,
        "title": widget.item.title,
        "description": widget.item.description,
        "image": widget.item.image,
        "quantity": quantity,
        "qtyLeft": widget.item.qtyLeft,
        "price": widget.item.price,
        "instruction": orderInstruction,
        "subTotal": (quantity * widget.item.price)
      };
      // print(newMenu);
      jsonData.add(newMenu);
      final insertedData = json.encode(jsonData);
      await storage.write(key: "carts", value: insertedData);
      // setState(() {
      //   quantity = 1;
      // });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
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
                'Cart Added Successfully',
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
      List jsonData = [];
      final newMenu = {
        "id": widget.item.id,
        "title": widget.item.title,
        "description": widget.item.description,
        "image": widget.item.image,
        "quantity": quantity,
        "qtyLeft": widget.item.qtyLeft,
        "price": widget.item.price,
        "instruction": orderInstruction,
        "subTotal": (quantity * widget.item.price)
      };

      jsonData.add(newMenu);
      final insertedData = json.encode(jsonData);
      await storage.write(key: "carts", value: insertedData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
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
                'Cart Added Successfully!',
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
    // const longtext =
    //     "Galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsumis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsumis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsumis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum";

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double width30 = screenWidth / 21.1;

    double height10 = screenHeight / 84.4;
    double height20 = screenHeight / 42.2;

    double font26 = screenHeight / 29.48;

    double radius20 = screenHeight / 42.2;

    double bottomHeightBar = screenHeight / 7.03;

    int total = 0;
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
                    Navigator.of(context).pop();
                  },
                  child: AppIcon(
                    icon: Icons.clear,
                    iconColor: Colors.white,
                    backgroundColor: Colors.orange,
                  )),
              GestureDetector(
                  onTap: () async {
                    FlutterSecureStorage storage = const FlutterSecureStorage();
                    var value = [];
                    total = 0;
                    var jsonString = await storage.read(key: "carts");

                    if (jsonString != null) {
                      var jsonDecoded = json.decode(jsonString);

                      value = jsonDecoded;

                      for (var data in jsonDecoded) {
                        int q = data['quantity'];
                        int pr = data['price'];
                        total += (q * pr);
                      }
                    }

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            CartPage(carts: value, total: total),
                      ),
                    );
                  },
                  child: AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: Colors.white,
                    backgroundColor: Colors.orange,
                  ))
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
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
              errorBuilder: (context, error, stackTrace) => Image.asset(
                "assets/images/f_0.png",
                fit: BoxFit.cover,
              ),
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
                  widget.item.description,
                  textAlign: TextAlign.start,
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
                    if (quantity <= 1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Row(
                            children: <Widget>[
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'you can\'t order 0',
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
                onTap: () async {
                  FlutterSecureStorage storage = const FlutterSecureStorage();
                  dynamic jsonData = null;
                  total = 0;
                  var jsonString = await storage.read(key: "carts");
                  if (jsonString != null) {
                    jsonData = await json.decode(jsonString);
                  }
                  num left = 0;
                  for (int i = 0; i < jsonData.length; ++i) {
                    if (jsonData[i]['title'] == widget.item.title) {
                      left += jsonData[i]['quantity'];
                    }
                  }

                  setState(() {
                    if (quantity >= widget.item.qtyLeft - left) {
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
                                'quantity left is only ${(widget.item.qtyLeft - left).toString()}',
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
                // print("written");
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
