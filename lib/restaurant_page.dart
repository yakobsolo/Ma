import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodly/components/menu_card.dart';
import 'package:foodly/components/restaruant_categories.dart';
import 'package:foodly/components/restaurant_info.dart';
import 'package:foodly/models/menu.dart';
import 'package:foodly/pages/detailsPage.dart';
import 'package:foodly/pages/drawer.dart';
import 'package:foodly/routes/routed.dart';
import 'package:get/get.dart';

import 'components/restuarant_app_bar.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final scrollController = ScrollController();
  int selectedCategoryIndex = 0;

  double restaruantInfoHeight = 200 + 170 - kToolbarHeight;
  @override
  void initState() {
    createdBreakPoints();
    scrollController.addListener(() {
      updateCategoryIndexOnScroll(scrollController.offset);
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void scrollToCategory(int index) {
    if (selectedCategoryIndex != index) {
      int totalItems = 0;

      for (var i = 0; i < index; i++) {
        totalItems += demoCategoryMenus[i].items.length;
      }
      scrollController.animateTo(
          restaruantInfoHeight + (116 * totalItems) + (50 * index),
          duration: Duration(microseconds: 500),
          curve: Curves.ease);

      setState(() {
        selectedCategoryIndex = index;
      });
    }
  }

  List<double> breackPoints = [];
  void createdBreakPoints() {
    double firstBreackPoint =
        restaruantInfoHeight + 50 + (116 * demoCategoryMenus[0].items.length);
    breackPoints.add(firstBreackPoint);

    for (var i = 1; i < demoCategoryMenus.length; i++) {
      double firstBreackPoint =
          restaruantInfoHeight + 50 + (116 * demoCategoryMenus[0].items.length);
      breackPoints.add(firstBreackPoint);
    }
  }

  void updateCategoryIndexOnScroll(double offset) {
    for (var i = 0; i < demoCategoryMenus.length; i++) {
      if (i == 0) {
        if ((offset < breackPoints.first) & (selectedCategoryIndex != 0)) {
          setState(() {
            selectedCategoryIndex = 0;
          });
        }
      } else if ((breackPoints[i - 1] <= offset) & (offset < breackPoints[i])) {
        if (selectedCategoryIndex != i) {
          selectedCategoryIndex = i;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          
          RestaurantAppBAr(),
          SliverToBoxAdapter(child: RestaurantInfo()),
          SliverPersistentHeader(
            delegate: RestaurantCategories(
                onChanged: scrollToCategory,
                selectedIndex: selectedCategoryIndex),
            pinned: true,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  List<Menu> items = demoCategoryMenus[index].items;
                  return MenuCategoryItem(
                      title: demoCategoryMenus[index].category,
                      items: List.generate(
                          items.length,
                          (idx) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: GestureDetector(
                                  onTap: () {
                                    print(items[idx]);
                                    Get.toNamed(RouteHelper.foodDetail, arguments: 0);
                                  },
                                  child: MenuCard(
                                      image: items[idx].image,
                                      title: items[idx].title,
                                      price: items[idx].price),
                                ),
                              )));
                },
                childCount: demoCategoryMenus.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
