
import 'package:flutter/material.dart';
import 'package:foodly/models/shop.dart';
import 'package:foodly/routes/routed.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context)=> Shop(),
      child: const MyApp(), 
      ),
      
      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way',
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}
