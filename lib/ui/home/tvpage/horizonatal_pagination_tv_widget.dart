import 'package:cinematics/model/TvResponse/TvResult.dart';
import 'package:cinematics/ui/home/tvpage/tv_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../commonui/list_item_poster.dart';

Widget  horizontalPaginationTvWidget(BuildContext context , List<TvResult> movieList , RxDouble offset , ScrollController scrollController, TelevisionController movieController ){
  return  Stack(
    children: [

      movieController.isLoadingPagination.isTrue ? const Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            height: 100,
            width: 100,
            child: Center(child: CircularProgressIndicator()),
          )): const Text(""),

      ListView.builder(
        key: PageStorageKey(offset),
        controller: scrollController,
        padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.2),
        scrollDirection: Axis.horizontal,
        itemCount: movieList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => {
              movieController.onTapItem.value = true,
              movieController.detailScreenRoute(
                  movieList[index],context)
            },
            child: listItemPosterMovies(
                context,
                movieList[index].posterPath
                    .toString()),
          );
        },
      ),
    ],
  );
}