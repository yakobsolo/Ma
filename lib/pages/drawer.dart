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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: BigText(
              text: "Yakob Solomon",
              color: Colors.white,
            ),
            accountEmail: SmallText(
              text: "yakisolo2009@gmail.com",
              color: Colors.white,
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("assets/images/f_0.png"),
              ),
            ),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              // image: DecorationImage(image: AssetImage("assets/images/f_2.png"),fit: BoxFit.cover)
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite_border_outlined),
            title: BigText(
              text: "Favorite",
              size: Dimensions.font20 / 1.2,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: BigText(
              text: "Notifications",
              size: Dimensions.font20 / 1.2,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.favorite_border_outlined),
            title: BigText(
              text: "Favorite",
              size: Dimensions.font20 / 1.2,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: BigText(
              text: "Cart",
              size: Dimensions.font20 / 1.2,
            ),
            onTap: () {
              Get.toNamed(
                RouteHelper.getCart(),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: BigText(
              text: "Signout",
              size: Dimensions.font20 / 1.2,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
