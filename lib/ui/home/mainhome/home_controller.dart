import 'package:cinematics/ui/FavoriteDetail/FavoriteController.dart';
import 'package:cinematics/ui/FavoriteDetail/Favorites.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../moviepage/movies.dart';
import '../searchpage/search.dart';
import '../tvpage/television.dart';

class HomeController extends GetxController {
  var pageIndex = 0.obs;

  void updatePageIndex(int value) {
    pageIndex.value = value;

    Future.delayed(const Duration(milliseconds: 100), () {
      if (value == 2) {
        Get.find<FavoriteController>().fetchData();
      }
    });

  }

  List<Widget> getPages() {
    return [
      pageIndex.value == 0 ? Movies() : const Scaffold(),
      pageIndex.value == 1 ? Televisions() : const Scaffold(),
      pageIndex.value == 2 ? FavoriteScreen() : const Scaffold(),
      pageIndex.value == 3 ? Search() : const Scaffold()
    ];
  }
}
