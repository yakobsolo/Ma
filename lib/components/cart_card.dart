import 'package:flutter/material.dart';
import 'package:foodly/uttils/Dimensions.dart';
import 'package:foodly/widgets/big_text.dart';

class CartCard extends StatelessWidget {

  final String image, title;
  final double price;
  final String instructions;
  final int amount;

  CartCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.amount,
    required this.instructions,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Image.asset(image),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.black54),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        instructions,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        
                        children: [
                          Icon(Icons.remove),
                          SizedBox(width: Dimensions.width20,),
                          BigText(text: "$amount",),
                          SizedBox(width: Dimensions.width20,),
                          Icon(Icons.add, color: Colors.orange,),
                        ],
                      )
                    ],
                  ),
                ),
                Text(
                      "\$$price",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.orange,
                      ),
                    )
                  
              ],
            ),
          ),
        )
      ],
    );
  }
}
