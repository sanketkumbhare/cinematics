import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinematics/commonui/text_widget.dart';
import 'package:cinematics/model/TvResponse/TvResult.dart';
import 'package:cinematics/model/castResponse/Cast.dart';
import 'package:cinematics/model/movieResponse/Results.dart';
import 'package:cinematics/ui/personDetail/person_controller.dart';
import 'package:cinematics/util/util.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../appstrings/app_constants.dart';
import '../../commonui/list_item_poster.dart';

class PersonDetail extends StatelessWidget {
  final PersonController controller;

  const PersonDetail({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.fetchAll(context);
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.27,
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl:
                      "$IMAGE_LOADING_BASE_URL_780${controller.getBackdropPath()}",
                  placeholder: (context, url) => const Icon(Icons.image),
                  errorWidget: (context, url, error) => const Icon(Icons.image),
                ),
              ),
              Hero(
                tag: "animate${controller.cast?.id}",
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(
                      left: 10, top: MediaQuery.of(context).size.height * 0.15),
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: Center(
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      margin: const EdgeInsets.all(5),
                      child: CachedNetworkImage(
                        width: MediaQuery.of(context).size.width * 0.33,
                        height: MediaQuery.of(context).size.height * 0.22,
                        fit: BoxFit.fill,
                        imageUrl:
                            "$IMAGE_LOADING_BASE_URL_780${controller.cast?.profilePath}",
                        placeholder: (context, url) => const Icon(Icons.image),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.image),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20),
                child: IconButton(
                  icon: const IconTheme(
                    data: IconThemeData(color: Colors.white, size: 25),
                    child: Icon(Icons.arrow_back),
                  ),
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(context),
                ),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.27,
                      left: MediaQuery.of(context).size.width * 0.35),
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.cast?.originalName}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                          ),
                          Text(
                              "Birthday: ${controller.personDetail.value.birthday == null ? "" : dateConversion(controller.personDetail.value.birthday!)}"),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                          ),
                          Text(
                              "Birth Place: ${controller.personDetail.value.placeOfBirth}"),
                        ],
                      ))),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.45,
                    left: 10,
                    right: 10),
                child: Column(
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                            child: Obx(() => ExpandableText(
                                  "${controller.personDetail.value.biography}",
                                  expandText: "show more ...",
                                  maxLines: 4,
                                )))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(left: 2),
                      child: getTextWidget("Acted In Movies"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.22,
                      child: Obx(
                        () => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.movieList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return listItemPosterMovies(
                                context,
                                controller.movieList[index].posterPath
                                    .toString());
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(left: 2),
                      child: getTextWidget("Acted In Tv Shows"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.22,
                      child: Obx(
                        () => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.tvList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => {
                                controller.onTapItem.value = true,
                                controller.detailTvScreenRoute(
                                    controller.tvList[index], context)
                              },
                              child: listItemPosterMovies(
                                  context,
                                  controller.tvList[index].posterPath
                                      .toString()),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
