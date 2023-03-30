
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return GetMaterialApp(
      home: Scaffold(

          body: Obx(
            () => IndexedStack(
              index: homeController.pageIndex.value,
              children: homeController.pages,
            ),
          ),
          bottomNavigationBar: Obx(() => BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  homeController.updatePageIndex(index);
                },
                currentIndex: homeController.pageIndex.value,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.movie),
                    label: "Movies",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.tv),
                    label: "Tv",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.supervised_user_circle),
                    label: "Saved",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: "Search",
                  )
                ],
              ))
          ),
    );
  }
}
