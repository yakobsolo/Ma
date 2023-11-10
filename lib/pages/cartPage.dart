import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:maleda/widgets/big_text.dart';

import '../components/cart_card.dart';

class CartPage extends StatefulWidget {
  final List carts;
  const CartPage({super.key, required this.carts});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalPrice = 0;

  FlutterSecureStorage storage = const FlutterSecureStorage();

  updateTotalPrice(int price) {
    setState(() {
      totalPrice += price;
    });
  }

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

    List<dynamic> items = widget.carts;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Center(
            child: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, idx) {
                  return Padding(
                    padding:
                        EdgeInsets.only(left: width30, right: width30, top: 16),
                    child: CartCard(
                      image: items[idx]['image'],
                      title: items[idx]['title'],
                      price: items[idx]['price'],
                      amount: items[idx]['quantitiy'],
                      instructions: items[idx]['description'],
                      qtyLeft: items[idx]['qtyLeft'],
                      updateTotal: updateTotalPrice,
                    ),
                  );
                }),
          ),
          Container(
            padding: EdgeInsets.only(
                left: width30,
                right: width30,
                bottom: height20 * 2,
                top: height20 + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width20, right: width20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Payment",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      BigText(
                        text: "\$$totalPrice",
                        color: Colors.orange,
                      )
                    ],
                  ),
                ),
                SizedBox(height: height30),
                Center(
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: width30 * 7,
                          right: width30 * 7,
                          top: height20,
                          bottom: height20),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(radius20),
                      ),
                      child: BigText(
                        text: "Checkout",
                        color: Colors.white,
                      ),
                    ),
                    onTap: () async {
                      final jsonString = await storage.read(key: "carts");
                      var items = [];

                      if (jsonString != null) {
                        final jsonData = json.decode(jsonString);

                        for (var value in jsonData) {
                          var new_data = {};
                          new_data["name"] = value['title'];
                          new_data['price'] = value['price'];
                          new_data['quantity'] = value['quantitiy'];
                          new_data['currency'] = "USD";

                          items.add(new_data);
                        }
                      }

                      await storage.deleteAll();

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => UsePaypal(
                              sandboxMode: true,
                              clientId:
                                  "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                              secretKey:
                                  "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                              returnURL: "https://samplesite.com/return",
                              cancelURL: "https://samplesite.com/cancel",
                              transactions: [
                                {
                                  "amount": {
                                    "total": '10.12',
                                    "currency": "USD",
                                    "details": {
                                      "subtotal": '10.12',
                                      "shipping": '0',
                                      "shipping_discount": 0
                                    }
                                  },
                                  "description":
                                      "The payment transaction description.",
                                  // "payment_options": {
                                  //   "allowed_payment_method":
                                  //       "INSTANT_FUNDING_SOURCE"
                                  // },
                                  "item_list": {
                                    "items": items,

                                    // shipping address is not required though
                                    "shipping_address": {
                                      "recipient_name": "Jane Foster",
                                      "line1": "Travis County",
                                      "line2": "",
                                      "city": "Austin",
                                      "country_code": "US",
                                      "postal_code": "73301",
                                      "phone": "+00000000",
                                      "state": "Texas"
                                    },
                                  }
                                }
                              ],
                              note:
                                  "Contact us for any questions on your order.",
                              onSuccess: (Map params) async {
                                print("onSuccess: $params");
                              },
                              onError: (error) {
                                print("onError: $error");
                              },
                              onCancel: (params) {
                                print('cancelled: $params');
                              }),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
