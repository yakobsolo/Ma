// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';

import 'package:maleda/bloc/product_bloc/product_bloc_bloc.dart';
import 'package:maleda/components/menu_card.dart';
import 'package:maleda/components/restaruant_categories.dart';
import 'package:maleda/components/restaurant_info.dart';
import 'package:maleda/models/menu.dart';
import 'package:maleda/pages/detailsPage.dart';
import 'package:maleda/pages/drawer.dart';
import 'package:maleda/routes/routed.dart';

import 'components/restuarant_app_bar.dart';

class RestaurantPage extends StatefulWidget {
  final List<CategoryMenu> demoCategoryMenus;

  const RestaurantPage({
    Key? key,
    required this.demoCategoryMenus,
  }) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final scrollController = ScrollController();
  int selectedCategoryIndex = 0;

  double restaruantInfoHeight = 200 + 170 - kToolbarHeight;
  @override
  void initState() {
    // print("here")
    createdBreakPoints();
    scrollController.addListener(() {
      updateCategoryIndexOnScroll(scrollController.offset);
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollToCategory(int index) {
    if (selectedCategoryIndex != index) {
      int totalItems = 0;

      for (var i = 0; i < index; i++) {
        totalItems += widget.demoCategoryMenus[i].items.length;
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
    double firstBreackPoint = 0;
    if (widget.demoCategoryMenus.length > 1) {
      firstBreackPoint = restaruantInfoHeight +
          50 +
          (116 * widget.demoCategoryMenus[0].items.length);
      breackPoints.add(firstBreackPoint);
    }

    for (var i = 1; i < widget.demoCategoryMenus.length; i++) {
      double firstBreackPoint = restaruantInfoHeight +
          50 +
          (116 * widget.demoCategoryMenus[0].items.length);
      breackPoints.add(firstBreackPoint);
    }
  }

  void updateCategoryIndexOnScroll(double offset) {
    for (var i = 0; i < widget.demoCategoryMenus.length; i++) {
      if (i == 0) {
        if ((offset < breackPoints.first) && (selectedCategoryIndex != 0)) {
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
          SliverPersistentHeader(
            delegate: RestaurantCategories(
                demoCategoryMenus: widget.demoCategoryMenus,
                onChanged: scrollToCategory,
                selectedIndex: selectedCategoryIndex),
            pinned: true,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  List<Menu> items = widget.demoCategoryMenus[index].items;
                  return MenuCategoryItem(
                      title: widget.demoCategoryMenus[index].category,
                      items: List.generate(
                          items.length,
                          (idx) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: GestureDetector(
                                  onTap: () {
                                    // print("item");
                                    // print(items[idx]);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RecommendFoodDetail(
                                          item: items[idx],
                                        ),
                                      ),
                                    );
                                  },
                                  child: MenuCard(
                                      image: items[idx].image,
                                      title: items[idx].title,
                                      price: items[idx].price),
                                ),
                              )));
                },
                childCount: widget.demoCategoryMenus.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
