import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinematics/ui/moviedetail/MovieDetailController.dart';
import 'package:cinematics/ui/tvdetail/TvDetailController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../appstrings/AppConstants.dart';
import '../../commonui/list_item_poster.dart';
import '../../commonui/text_widget.dart';

class TvDetail extends StatelessWidget {
  final String tagValue;
  late TvDetailController controller;

  String? get tag => tagValue;

  TvDetail(this.tagValue, {Key? key}) : super(key: key){
    controller = Get.put(TvDetailController(),tag: tagValue);
  }

  @override
  Widget build(BuildContext context) {
    controller.getArguments();
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
                    title: Text("${controller.tvResult.name}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Stack(
                      children: [
                        SizedBox(
                          height: double.infinity,
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: IMAGE_LOADING_BASE_URL_780 +
                                controller.tvResult.backdropPath.toString(),
                            placeholder: (context, url) =>
                                const Icon(Icons.image),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.image),
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: Obx(
                              () => controller.youtubeList.isNotEmpty == true
                                  ? IconButton(
                                      onPressed: () => {
                                        controller.launch(controller
                                            .youtubeList[0].key
                                            .toString())
                                      },
                                      icon: const IconTheme(
                                        data: IconThemeData(
                                            color: Colors.white, size: 60),
                                        child: Icon(Icons.play_circle),
                                      ),
                                    )
                                  : const Text(""),
                            )),
                      ],
                    )),
                leading: IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => {Get.back()},
                ),
                actions: [
                  Obx(
                    () => controller.savedClicked.value == false
                        ? IconButton(
                            onPressed: () => {
                              controller.savedClicked.value = true,
                              controller.addTv(controller.tvResult)
                            },
                            icon: const IconTheme(
                              data:
                                  IconThemeData(color: Colors.white, size: 25),
                              child: Icon(Icons.save_outlined),
                            ),
                          )
                        : IconButton(
                            onPressed: () => {},
                            icon: const IconTheme(
                              data:
                                  IconThemeData(color: Colors.white, size: 25),
                              child: Icon(Icons.save),
                            ),
                          ),
                  )
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
                      Expanded(child: Text("${controller.tvResult.overview}"))
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
                  child: Obx(
                    () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.castList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () => {
                            controller.onTapItem.value = true,
                            controller.routeToPersonDetail(
                                controller.castList[index], controller.tvResult)
                          },
                          child: listItemPosterMovies(
                              context, controller.castList[index].profilePath.toString()),
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
                  child: getTextWidget(textSimilarTv),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: Obx(
                    () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.similarTvList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () => {
                            controller.onTapItem.value = true,
                            controller.detailTvScreenRoute(controller.similarTvList[index])
                          },
                          child: listItemPosterMovies(
                              context,
                              controller.similarTvList[index].posterPath
                                  .toString()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
