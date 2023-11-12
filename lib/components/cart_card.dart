import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maleda/widgets/big_text.dart';

class CartCard extends StatefulWidget {
  final String image, title;
  final int price;
  final String instructions;
  final int amount;
  final int qtyLeft;
  final updateTotal;
  final subTotal;
  final description;

  CartCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.amount,
    required this.instructions,
    required this.qtyLeft,
    this.updateTotal,
    this.subTotal,
    this.description,
  }) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  late int quantity = widget.amount;
  FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double width10 = screenWidth / 84.4;
    double width20 = screenWidth / 42.2;
    double width30 = screenWidth / 21.1;

    double height10 = screenHeight / 84.4;
    double height20 = screenHeight / 42.2;
    double height30 = screenHeight / 21.1;

    double font20 = screenHeight / 42.2;
    double font26 = screenHeight / 29.48;
    double radius10 = screenHeight / 84.4;
    double radius20 = screenHeight / 42.2;
    double radius30 = screenHeight / 21.1;

    // list view Size

    double listViewImgSize = screenWidth / 3.25;
    double listViewTextContSize = screenWidth / 3.9;

    //detail food

    double foodImageSize = screenHeight / 2.41;

    // icon Size

    double iconSize24 = screenHeight / 35.17;
    double iconSize16 = screenHeight / 52.75;

    // bottome height

    double bottomHeightBar = screenHeight / 7.03;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: screenWidth / 4,
          height: 100,
          child: Image.network(
              "https://maleda-backend.onrender.com/${widget.image}"),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.black54),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title.toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '\$${widget.price * quantity}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            int before = 0;
                            final jsonString = await storage.read(key: "carts");
                            if (jsonString != null) {
                              final jsonData = json.decode(jsonString);
                              // print(jsonData);
                              for (int i = 0; i < jsonData.length; ++i) {
                                if (jsonData[i]['title'] == widget.title) {
                                  int cnt = jsonData[i]["quantity"];
                                  before += cnt;
                                }
                              }
                            }
                            // print("hahahahaha");
                            // print(quantity + before);
                            // print(quantity);
                            // print(before);

                            if (before < widget.qtyLeft) {
                              setState(() {
                                quantity += 1;
                                widget.updateTotal(widget.price);
                              });
                              final jsonString =
                                  await storage.read(key: 'carts');
                              if (jsonString != null) {
                                final jsonData = json.decode(jsonString);
                                var newJsonData = [];
                                for (var value in jsonData) {
                                  if (value['title'] == widget.title &&
                                      value['instruction'] ==
                                          widget.instructions) {
                                    value['quantity'] = quantity;
                                    value['subTotal'] =
                                        (quantity * value['price']);
                                  }
                                  newJsonData.add(value);
                                }
                                final JsonString = json.encode(newJsonData);
                                await storage.write(
                                    key: 'carts', value: JsonString);
                              }
                            } else {
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
                            }
                          },
                          child: Icon(
                            Icons.add,
                          ),
                        ),
                        SizedBox(
                          width: width20,
                        ),
                        BigText(
                          text: "${quantity}",
                        ),
                        // SizedBox(
                        //   width: width20,
                        // ),
                        GestureDetector(
                          onTap: () async {
                            if (quantity > 1) {
                              setState(() {
                                quantity -= 1;
                                widget.updateTotal((-1 * widget.price));
                              });

                              final jsonString =
                                  await storage.read(key: 'carts');
                              if (jsonString != null) {
                                final jsonData = json.decode(jsonString);
                                var newJsonData = [];
                                for (var value in jsonData) {
                                  if (value['title'] == widget.title &&
                                      value['instruction'] ==
                                          widget.instructions) {
                                    value['quantity'] = quantity;
                                    value['subtotal'] =
                                        (quantity * value['price']);
                                  }
                                  newJsonData.add(value);
                                }
                                final JsonString = json.encode(newJsonData);
                                await storage.write(
                                    key: 'carts', value: JsonString);
                              }
                            } else {
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
                            }
                          },
                          child: Icon(
                            Icons.remove,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
