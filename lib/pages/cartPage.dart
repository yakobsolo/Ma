// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'package:foodly/uttils/colors.dart';
import 'package:foodly/widgets/big_text.dart';
import 'package:foodly/widgets/small_text.dart';

import '../models/menu.dart';
import '../models/shop.dart';

class CartPage extends StatefulWidget {
  final List<dynamic> carts;
  const CartPage({
    Key? key,
    required this.carts,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  void removeFromCart(Menu foodName, BuildContext ctxt) {
    final shop = ctxt.read<Shop>();
    setState(() {
      shop.removeFromCart(foodName);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double width20 = screenWidth / 42.2;

    double height20 = screenHeight / 42.2;

    double radius10 = screenHeight / 84.4;

    return Scaffold(
      // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Center(child: Text("My Cart")),
        backgroundColor: AppColors.mainColor,
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
              itemCount: widget.carts.length,
              itemBuilder: (context, index) {
                final food = widget.carts[index];
                final String foodName = food['title'];
                final int foodPrice = food['itemPrice'];
                print(food);
                return Container(
                  margin: EdgeInsets.only(
                      left: width20, right: width20, top: height20),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(radius10)),
                  child: ListTile(
                    title: BigText(
                      text: foodName,
                      color: Colors.black54,
                    ),
                    subtitle: SmallText(
                      text: foodPrice.toString(),
                      color: Colors.black54,
                    ),
                    trailing: GestureDetector(
                        onTap: () {
                          removeFromCart(food, context);
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.black54,
                        )),
                  ),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              primary: const Color(0xFF22A45D),
              fixedSize: const Size(240, 50),
              side: const BorderSide(color: Color(0xFF22A45D)),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            child: Text(
              "Check Out".toUpperCase(),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        )
      ]),
    );
  }
}
