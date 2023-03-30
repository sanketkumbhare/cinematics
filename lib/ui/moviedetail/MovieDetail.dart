
import 'package:cinematics/ui/moviedetail/MovieDetailController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../appstrings/AppConstants.dart';
import '../../commonui/list_item_poster.dart';
import '../../commonui/text_widget.dart';

class MovieDetail extends GetView<MovieDetailController> {
  final String tagVal;
  const MovieDetail(this.tagVal, {Key? key}) : super(key: key);
  @override
  String? get tag => tagVal;

  @override
  Widget build(BuildContext context) {
    Get.put(MovieDetailController(), tag: tagVal);
    controller.setArguments();
    return MaterialApp(
      home: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("${controller.movieResult.title}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          child: Image.network(
                            IMAGE_LOADING_BASE_URL_780 +
                                controller.movieResult.backdropPath
                                    .toString(),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Obx(() => controller
                                      .getYoutubeList()
                                      .isNotEmpty ==
                                  true
                              ? IconButton(
                                  onPressed: () => {
                                    controller.launch(
                                        controller
                                            .getYoutubeList()[0]
                                            .key
                                            .toString())
                                  },
                                  icon: const IconTheme(
                                    data: IconThemeData(
                                        color: Colors.white, size: 60),
                                    child: Icon(Icons.play_circle),
                                  ),
                                )
                              : const Text("")),
                        )
                      ],
                    )),
                leading: IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => {Get.back()},
                ),
                actions: [
                  Obx(() => controller.savedClicked.value == false
                      ? IconButton(
                          onPressed: () => {
                            controller.savedClicked.value = true,
                            controller
                                .addMovie(controller.movieResult)
                          },
                          icon: const IconTheme(
                            data: IconThemeData(color: Colors.white, size: 25),
                            child: Icon(Icons.save_outlined),
                          ),
                        )
                      : IconButton(
                          onPressed: () => {
                            controller.savedClicked.value = false,
                            controller.deleteMovie(
                                controller.movieResult.id!)
                          },
                          icon: const IconTheme(
                            data: IconThemeData(color: Colors.white, size: 25),
                            child: Icon(Icons.save),
                          ),
                        ))
                ],
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.topCenter,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                          child: Text(
                              "${controller.movieResult.overview}"))
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 10),
                  child: getTextWidget(textCast),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.22,
                    child: Obx(() => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.getCastList().length,
                          itemBuilder: (BuildContext context, int index) {
                            return  InkWell(
                                onTap: () => {
                                  controller.onTapItem.value = true,
                                  controller.routeToPersonDetail(
                                      controller.getCastList()[index],
                                      controller.movieResult)
                                },
                                child: Hero(
                                  tag: "animate${controller.getCastList()[index].id}",
                                  child: listItemPosterMovies(context,
                                      controller.getCastList()[index].profilePath.toString()),
                                ),
                              );
                          },
                        ))),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 10),
                  child: getTextWidget(textSimilarMovies),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.22,
                    child: Obx(() => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller
                              .getSimilarMovieList()
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                controller.onTapItem.value = true;
                                controller.detailScreen(
                                    controller
                                        .getSimilarMovieList()[index]);
                              },
                              child: listItemPosterMovies(
                                  context,
                                  controller
                                      .getSimilarMovieList()[index]
                                      .posterPath
                                      .toString()),
                            );
                          },
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
