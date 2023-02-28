import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:maleda/pages/cartPage.dart";
import "package:maleda/uttils/Dimensions.dart";
import "package:maleda/uttils/colors.dart";
import "package:maleda/widgets/big_text.dart";
import "package:maleda/widgets/small_text.dart";
import "package:get/get.dart";

import "../routes/routed.dart";

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    int total = 0;
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
            decoration: const BoxDecoration(
              color: Colors.orange,
              // image: DecorationImage(image: AssetImage("assets/images/f_2.png"),fit: BoxFit.cover)
            ),
          ),
          ListTile(
            leading: const Icon(
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
              Navigator.of(context).pushNamed("/");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.shopping_cart,
              color: Colors.orange,
              size: 20,
            ),
            title: Text(
              "Cart",
              style: TextStyle(fontSize: 15, color: Colors.orange),
            ),
            onTap: () async {
              FlutterSecureStorage storage = const FlutterSecureStorage();
              var value = [];
              total = 0;
              var jsonString = await storage.read(key: "carts");

              if (jsonString != null) {
                var jsonDecoded = json.decode(jsonString);

                value = jsonDecoded;
                print("app");
                print(jsonDecoded);
                for (var data in jsonDecoded) {
                  int q = data['quantity'];
                  int pr = data['price'];
                  total += (q * pr);
                }
                print(total);
              }

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CartPage(carts: value, total: total),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
