// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:maleda/widgets/big_text.dart';

import '../components/cart_card.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  final List carts;
  final int total;
  const CartPage({
    Key? key,
    required this.carts,
    required this.total,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late int totalPrice = widget.total;

  FlutterSecureStorage storage = const FlutterSecureStorage();
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phoneNumber;
  late TextEditingController pickUpTime;
  List<String> timeSlots = [];

  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    email = TextEditingController();
    phoneNumber = TextEditingController();

    generateTimeSlots();
    dropdownValue = timeSlots[0];
  }

  void generateTimeSlots() {
    DateTime date = DateTime.now();
    int day = date.weekday;
    DateTime start, end;
    int interval;

    if (day >= 1 && day <= 3) {
      start = DateTime(date.year, date.month, date.day, 9, 45, 0, 0);
      end = DateTime(date.year, date.month, date.day, 19, 0, 0, 0);
      interval = 15;
    } else if (day >= 4 && day <= 6) {
      start = DateTime(date.year, date.month, date.day, 9, 45, 0, 0);
      end = DateTime(date.year, date.month, date.day, 19, 30, 0, 0);
      interval = 15;
    } else {
      start = DateTime(date.year, date.month, date.day, 10, 15, 0, 0);
      end = DateTime(date.year, date.month, date.day, 18, 30, 0, 0);
      interval = 15;
    }

    while (start.isBefore(end)) {
      timeSlots.add(formatTime(start));
      start = start.add(Duration(minutes: interval));
    }
  }

  String formatTime(DateTime time) {
    return '${time.hour}:${time.minute}';
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    email.dispose();
    phoneNumber.dispose();
  }

  updateTotalPrice(int price) {
    setState(() {
      totalPrice += price;
    });
  }

  Future<dynamic> openDiag() => showDialog<dynamic>(
        context: context,
        builder: (context) => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: AlertDialog(
            title: const Text(
              "Enter Your Contact Information",
              style: TextStyle(
                color: Colors.orange,
                fontSize: 15,
              ),
            ),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: name,
                    decoration:
                        const InputDecoration(hintText: "Enter Your Name"),
                  ),
                  TextField(
                    controller: email,
                    decoration:
                        const InputDecoration(hintText: "Enter your Email"),
                  ),
                  TextField(
                    controller: phoneNumber,
                    decoration:
                        const InputDecoration(hintText: "Phone Number Here"),
                  ),
                  // Text(
                  //   "Pick up Time",
                  // ),
                  DropdownButton(
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      style: const TextStyle(color: Colors.orange),
                      items: timeSlots
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      }),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop({
                    "name": name.text,
                    "email": email.text,
                    "phoneNumber": phoneNumber.text,
                    "pickUpTime": dropdownValue,
                  });
                },
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    // print("total");
    // print(totalPrice);
    // print(timeSlots);
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
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: const Center(
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
                      amount: items[idx]['quantity'],
                      description: items[idx]['description'],
                      subTotal: items[idx]['subTotal'],
                      instructions: items[idx]['instruction'],
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
                      const Text(
                        "Total Payment",
                        style: TextStyle(
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
                      // await storage.deleteAll();

                      if (jsonString != null) {
                        final jsonData = json.decode(jsonString);
                        // print("cart cart cart");
                        // print(jsonData);
                        for (var value in jsonData) {
                          var new_data = {};
                          new_data["name"] = value['title'];
                          new_data['price'] = value['price'];
                          new_data['quantity'] = value['quantity'];
                          new_data['currency'] = "USD";

                          items.add(new_data);
                        }
                      }
                      // print("diag");
                      dynamic userData = await openDiag();
                      print(userData);
                      if (userData['name'] != null &&
                          userData['email'] != null &&
                          userData['phoneNumber'] != null &&
                          userData['name'] != "" &&
                          userData['email'] != "" &&
                          userData['phoneNumber'] != "") {
                        // print(userData);
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
                                      "total": totalPrice,
                                      "currency": "USD",
                                      // "details": const {
                                      //   // "subtotal": '10.12',
                                      //   "shipping": '0',
                                      //   "shipping_discount": 0
                                      // }
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
                                      "shipping_address": const {
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
                                  var user = {
                                    "userName": userData['name'],
                                    "userEmail": userData['email'],
                                    "userPhoneNumber": userData['phoneNumber'],
                                    "payed": true,
                                    "pickUpTime": userData["pickUpTime"],
                                    "totalPrice": totalPrice,
                                    "instructions": "inst"
                                  };

                                  var product = [];

                                  // final jsonString = await storage.read(key: "carts");
                                  if (jsonString != null) {
                                    final jsonData = json.decode(jsonString);
                                    for (var data in jsonData) {
                                      product.add({
                                        "title": data['title'],
                                        "id": data["id"],
                                        "totalPrice": data["subTotal"],
                                        "quantity": data["quantity"]
                                      });
                                    }
                                  }

                                  final payload = {
                                    "user": user,
                                    "cart": product,
                                  };

                                  final req = json.encode(payload);

                                  final uri = Uri.parse(
                                      "https://maleda-backend.onrender.com/order");
                                  final response = await http.post(uri,
                                      headers: <String, String>{
                                        "Content-Type": "application/json"
                                      },
                                      body: req);
                                  print("response");
                                  final newresponse =
                                      json.decode(response.body);
                                  print(newresponse);
                                  await storage.delete(key: "carts");
                                },
                                onError: (error) {
                                  print("onError: $error");
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
                                            'Error while paying',
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
                                },
                                onCancel: (params) {
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
                                            'Payment Canceled',
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
                                }),
                          ),
                        );
                      }
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
