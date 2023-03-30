import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinematics/ui/FavoriteDetail/FavoriteController.dart';
import 'package:cinematics/commonui/list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../appstrings/AppConstants.dart';

Widget getMovieList(FavoriteController controller, String tabValue) {
  return Obx(() => ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: tabValue == "Movie"
          ? controller.movieList.length
          : controller.tvList.length,
      itemBuilder: (context, index) {
        return tabValue == "Movie"
            ? InkWell(
          onTap: (){
            controller.onTapItem.value = true;
            controller.detailScreen(controller.movieList[index]!);
          },
              child: listItems(
                  context,
                  controller.movieList[index]!.posterPath.toString(),
                  controller.movieList[index]!.title.toString(),
                  controller.movieList[index]!.overview.toString()),
            )
            : InkWell(
          onTap: (){
            controller.onTapItem.value = true;
            controller.detailTvScreenRoute(controller.tvList[index]!);
          },
              child: listItems(
                  context,
                  controller.tvList[index]!.posterPath.toString(),
                  controller.tvList[index]!.name.toString(),
                  controller.tvList[index]!.overview.toString()),
            );
      }));
}
