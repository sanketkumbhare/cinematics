import 'package:cinematics/appstrings/AppConstants.dart';
import 'package:cinematics/commonui/list_item.dart';
import 'package:cinematics/commonui/list_item_poster.dart';
import 'package:cinematics/ui/home/moviepage/HorizontalPaginationWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../commonui/text_widget.dart';
import 'movie_controller.dart';

class Movies extends StatelessWidget {
   Movies({Key? key}) : super(key: key);

  final MovieController movieController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("TMDB guide"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () => movieController.isLoading.value == true
              ? const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.27,
                        child: Obx(
                          () => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const PageScrollPhysics(),
                            itemCount:
                                movieController.movieNowPlayingList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () => {
                                  movieController.onTapItem.value = true,
                                  movieController.detailScreenRoute(
                                      movieController
                                          .movieNowPlayingList[index])
                                },
                                child: listItemMovies(
                                    context,
                                    movieController
                                        .movieNowPlayingList[index].backdropPath
                                        .toString(),
                                    movieController
                                        .movieNowPlayingList[index].title
                                        .toString()),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 10),
                        child: getTextWidget(textPopularMovies),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.22,
                          child: Obx(
                            () => horizontalPaginationWidget(
                                context,
                                movieController.moviePopularList,
                                movieController.popularListOffset,
                                movieController.controllerPopularMovies,
                                movieController),
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 10),
                        child: getTextWidget(textTopRatedMovies),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.22,
                        child: Obx(() => horizontalPaginationWidget(
                            context,
                            movieController.movieTopRatedList,
                            movieController.topMoviesListOffset,
                            movieController.controllerTopMovies,
                            movieController)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 10),
                        child: getTextWidget(textUpcomingMovies),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.22,
                        child: Obx(
                          () => horizontalPaginationWidget(
                              context,
                              movieController.movieUpcomingList,
                              movieController.upcomingMoviesListOffset,
                              movieController.controllerUpcomingMovies,
                              movieController),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    ));
  }
}
