import 'package:flutter/material.dart';
import 'package:foodly/uttils/Dimensions.dart';
import 'package:foodly/uttils/colors.dart';
import 'package:foodly/widgets/big_text.dart';
import 'package:foodly/widgets/small_text.dart';
import 'package:provider/provider.dart';

import '../models/menu.dart';
import '../models/shop.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void removeFromCart(Menu foodName, BuildContext ctxt) {
    final shop = ctxt.read<Shop>();
    setState(() {
        shop.removeFromCart(foodName);
    });
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(builder: (context, value, ChildBackButtonDispatcher) {
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
                itemCount: value.cart.length,
                itemBuilder: (context, index) {
                  print(value.cart.length.toString() + index.toString());
                  final Menu food = value.cart[index];

                  final String foodName = food.title;

                  final double foodPrice = food.price;

                  return Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        top: Dimensions.height20),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10)),
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
    });
  }
}
