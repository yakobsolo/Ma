import 'package:flutter/material.dart';
import 'package:foodly/models/cart.dart';
import 'package:foodly/uttils/Dimensions.dart';
import 'package:foodly/widgets/big_text.dart';

import '../components/cart_card.dart';

class CartPageNew extends StatefulWidget {
  const CartPageNew({super.key});

  @override
  State<CartPageNew> createState() => _CartPageNewState();
}

class _CartPageNewState extends State<CartPageNew> {
  
  @override
  Widget build(BuildContext context) {

    final double totalPrice = 0;

    List<Cart> items = [
      Cart(
        amount: 1,
        instructions: "instruc",
        price: 7.4,
        image: "assets/images/f_0.png",
        title: "Cookie Sandwich",
      ),
      Cart(
        amount: 1,
        instructions: "instruc",
        price: 9.0,
        image: "assets/images/f_1.png",
        title: "Chow Fun",
      ),
      Cart(
        amount: 1,
        instructions: "instruc",
        price: 8.5,
        image: "assets/images/f_2.png",
        title: "Dim SUm",
      ),
      Cart(
        amount: 1,
        instructions: "",
        price: 12.4,
        image: "assets/images/f_3.png",
        title: "Cookie Sandwich",
      ),
      Cart(
        amount: 1,
        instructions: "instruc",
        price: 7.4,
        image: "assets/images/f_0.png",
        title: "Cookie Sandwich",
      ),
      Cart(
        amount: 1,
        instructions: "instruc",
        price: 9.0,
        image: "assets/images/f_1.png",
        title: "Chow Fun",
      ),
      Cart(
        amount: 1,
        instructions: "instruc",
        price: 8.5,
        image: "assets/images/f_2.png",
        title: "Dim SUm",
      ),
      Cart(
        amount: 1,
        instructions: "",
        price: 12.4,
        image: "assets/images/f_3.png",
        title: "Cookie Sandwich",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
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
                    padding: EdgeInsets.only(
                        left: Dimensions.width30,
                        right: Dimensions.width30,
                        top: 16),
                    child: CartCard(
                      image: items[idx].image,
                      title: items[idx].title,
                      price: items[idx].price,
                      amount: items[idx].amount,
                      instructions: items[idx].instructions,
                    ),
                  );
                }),
          ),
          Container(
            
          padding: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height20*2, top: Dimensions.height20+10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
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
                    BigText(text: "\$$totalPrice", color: Colors.orange,)
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height30),
              Center(
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(left: Dimensions.width30*7, right: Dimensions.width30*7, top: Dimensions.height20, bottom: Dimensions.height20 ),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child: BigText(text: "Checkout", color: Colors.white,),
                  ),
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
