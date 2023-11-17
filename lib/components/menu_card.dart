import 'package:flutter/material.dart';

class MenuCategoryItem extends StatelessWidget {
  const MenuCategoryItem({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  final String title;
  final List items;

  @override
  Widget build(BuildContext context) {
    // print("items");
    // print(items);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...items,
      ],
    );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
  }) : super(key: key);

  final String image, title;
  final int price;

  @override
  Widget build(BuildContext context) {
    // print("image);
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0), // Adjust the radius
          child: Image.network(
            'https://maleda-backend.onrender.com/$image',
            width: 100, // Set width as needed
            height: 100, // Set height as needed
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Image.asset("assets/images/f_0.png",width: 100,height: 100, fit: BoxFit.cover,),), // Adjust how the image fits within the bounds
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
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orange,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Shortbread, chocolate turtle cookies, and red velvet.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    // const Text("\$\$"),
                    // const Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 8),
                    //   child: CircleAvatar(
                    //     radius: 2,
                    //     backgroundColor: Colors.black38,
                    //   ),
                    // ),
                    const Text(
                      "Chinese",
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "\$$price",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
