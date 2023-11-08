import "package:flutter/material.dart";
import "package:foodly/uttils/Dimensions.dart";
import "package:foodly/uttils/colors.dart";
import "package:foodly/widgets/big_text.dart";
import "package:foodly/widgets/small_text.dart";
import "package:get/get.dart";

import "../routes/routed.dart";

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Colors.orange,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(""),
            accountEmail: Text(""),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("assets/images/f_0.png"),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.orange,
              // image: DecorationImage(image: AssetImage("assets/images/f_2.png"),fit: BoxFit.cover)
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.orange,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                fontSize: 15,
                color: Colors.orange,
              ),
            ),
            onTap: () {
              // Get.toNamed(
              //   RouteHelper.getCart(),
              // );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_cart,
              color: Colors.orange,
              size: 20,
            ),
            title: Text(
              "Cart",
              style: TextStyle(fontSize: 15, color: Colors.orange),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
