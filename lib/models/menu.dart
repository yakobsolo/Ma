import 'dart:convert';

import 'package:maleda/api/BackendService.dart';
import 'package:get/get.dart';

class Menu {
  final String title, image, description, id;
  int price, qtyLeft;
  final int quantitiy;
  final int itemPrice;

  Menu(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.price,
      required this.qtyLeft,
      this.quantitiy = 0,
      this.itemPrice = 0});
}

class CategoryMenu {
  final String category;
  final List<Menu> items;

  CategoryMenu({required this.category, required this.items});
}
