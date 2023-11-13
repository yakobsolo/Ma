import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maleda/components/restaruant_categories.dart';
import 'package:maleda/models/Product.dart';
import 'package:maleda/models/menu.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'product_bloc_event.dart';
part 'product_bloc_state.dart';

class ProductBlocBloc extends Bloc<ProductBlocEvent, ProductBlocState> {
  ProductBlocBloc() : super(ProductBlocInitial()) {
    on<ProductBlocEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetProducts>(
      (event, emit) async {
        emit(ProductIsLoading());
        final uri = Uri.parse("https://maleda-backend.onrender.com/products");
        final response = await http.get(uri);
        final data = json.decode(response.body);
        final products = data['msg'];

        List<Product> product = [];
        for (var p in products) {
          final newProduct = Product(
            productName: p['productName'] as String,
            description: "Description",
            qtyLeft: p['qtyLeft'].toInt(),
            imgSrc: p['imgPath'][0] as String,
            price: p["price"].toInt(),
            id: p["_id"] as String,
            category: p['productCategory']["title"] as String,
          );
          product.add(newProduct);
        }

        final catagorized = {};

        for (var pr in product) {
          if (catagorized.containsKey(pr.category)) {
            catagorized[pr.category].add(pr);
          } else {
            catagorized[pr.category] = [pr];
          }
        }

        List<CategoryMenu> items = [];

        for (var key in catagorized.keys) {
          var pr = catagorized[key];
          List<Menu> item = [];
          for (var data in pr) {
            var menu = Menu(
                id: data.id is String ? data.id : "",
                title: data.productName is String ? data.productName : "",
                description: "This is test Description",
                image: data.imgSrc is String ? data.imgSrc : "",
                price: data.price is int ? data.price : "",
                qtyLeft: data.qtyLeft is int ? data.qtyLeft : 0);
            item.add(menu);
          }
          var categoryMenu = CategoryMenu(
            category: key,
            items: item,
          );
          items.add(categoryMenu);
        }

        FlutterSecureStorage storage = const FlutterSecureStorage();

        final jsonString = storage.read(key: "onboarding");

        if (jsonString != null) {
          emit(ProductIsLoaded(demoCategoryMenus: items));
        } else {
          emit(Onboarding());
        }
      },
    );
  }
}
