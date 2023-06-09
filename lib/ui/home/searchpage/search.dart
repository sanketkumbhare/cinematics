import 'package:cinematics/ui/home/searchpage/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../commonui/list.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);

  final SearchController controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("TMDB guide"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.06),
                height: MediaQuery.of(context).size.height,
                child: Obx(
                  () => controller.isLoading.value == true &&
                          controller.pageCount == 1
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * 0.1),
                          key: PageStorageKey(controller.persistPosition),
                          controller: controller.scrollController,
                          scrollDirection: Axis.vertical,
                          itemCount: controller.searchList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                controller.onTap.value == true;
                                print("tapped");
                                controller.detailScreen(
                                    controller.searchList[index], context);
                              },
                              child: listItems(
                                  context,
                                  controller.searchList[index].posterPath
                                      .toString(),
                                  controller.searchList[index].title == null
                                      ? controller.searchList[index].name
                                          .toString()
                                      : controller.searchList[index].title
                                          .toString(),
                                  controller.searchList[index].overview
                                      .toString()),
                            );
                          }),
                ),
              ),
              Container(
                color: Colors.white,
                child: TextField(
                  focusNode: controller.focusNode,
                  onChanged: (stringValue) {
                    controller.valueChanged(stringValue);
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search Movies, Tv shows, actors etc."),
                ),
              ),
              Obx(() =>
                  controller.isLoading.value == true && controller.pageCount > 1
                      ? const Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Center(child: CircularProgressIndicator()),
                          ))
                      : const Text(""))
            ],
          ),
        ));
  }
}
