import 'package:flutter/material.dart';
import 'package:maleda/models/menu.dart';

class Shop extends ChangeNotifier {
  final List<Menu> _foodMenu = [
    // Menu(
    //   price: 7.4,
    //   image: "assets/images/f_0.png",
    //   title: "Cookie Sandwich",
    // ),
    // Menu(
    //   price: 9.0,
    //   image: "assets/images/f_1.png",
    //   title: "Chow Fun",
    // ),
    // Menu(
    //   price: 8.5,
    //   image: "assets/images/f_2.png",
    //   title: "Dim SUm",
    // ),
    // Menu(
    //   price: 12.4,
    //   image: "assets/images/f_3.png",
    //   title: "Cookie Sandwich",
    // ),
  ];

  List<Menu> _cart = [];

  List<Menu> get foodMenu => _foodMenu;
  List<Menu> get cart => _cart;

  void addToCart(int i, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(foodMenu[i]);
    }
    notifyListeners();
  }

  void removeFromCart(Menu foodItem) {
    print(_cart);

    _cart.remove(foodItem);
    print(_cart);
    print(foodItem);
  }

  notifyListeners();
}
