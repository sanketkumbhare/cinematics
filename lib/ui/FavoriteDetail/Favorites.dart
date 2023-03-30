import 'package:cinematics/ui/FavoriteDetail/FavoriteController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'FavoriteMovies.dart';

class FavoriteScreen extends GetView<FavoriteController> {
   FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(FavoriteController());
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Favorites"),
          bottom: TabBar(
            controller: controller.tabController,
            onTap: (index) => controller.onTapIndexValue(index),
            tabs: const [
              Tab(
                child: Text("Movies",style: TextStyle(color: Colors.white),),
              ),
              Tab(
                child: Text("TV Show",style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: [
            Center(child: Obx(() => controller.movieList.isNotEmpty ? getMovieList(controller,"Movie") : const Text("You have No favorite Movies"))),
            Center(child: Obx(() => controller.tvList.isNotEmpty ? getMovieList(controller,"Tv") : const Text("You have No favorite Tv Shows"))),
          ],
        ),
      ),
    );
  }
}
