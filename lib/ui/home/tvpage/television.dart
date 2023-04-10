import 'package:cinematics/commonui/list_item.dart';
import 'package:cinematics/ui/home/tvpage/tv_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../appstrings/app_constants.dart';
import '../../../commonui/text_widget.dart';
import 'horizonatal_pagination_tv_widget.dart';

class Televisions extends StatelessWidget {
  Televisions({Key? key}) : super(key: key);

  final TelevisionController controller = Get.put(TelevisionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TMDB guide"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () => controller.isLoading.value == true
              ? const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.27,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const PageScrollPhysics(),
                          itemCount: controller.tvAiringTodayList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () => {
                                controller.onTapItem.value = true,
                                controller.detailScreenRoute(
                                    controller.tvAiringTodayList[index],
                                    context)
                              },
                              child: listItemMovies(
                                  context,
                                  controller
                                      .tvAiringTodayList[index].backdropPath
                                      .toString(),
                                  controller.tvAiringTodayList[index].name
                                      .toString()),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 10),
                        child: getTextWidget(textTopRatedTv),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.22,
                          child: horizontalPaginationTvWidget(
                              context,
                              controller.tvTopRatedList,
                              controller.topRatedTvListOffset,
                              controller.controllerTopRatedTv,
                              controller)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 10),
                        child: getTextWidget(textPopularTv),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.22,
                          child: horizontalPaginationTvWidget(
                              context,
                              controller.tvPopularList,
                              controller.popularTvListOffset,
                              controller.controllerPopularTv,
                              controller)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 10),
                        child: getTextWidget(textOnAirTv),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.22,
                          child: horizontalPaginationTvWidget(
                              context,
                              controller.tvOnAirList,
                              controller.tvAirListOffset,
                              controller.controllerTvAir,
                              controller)),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
