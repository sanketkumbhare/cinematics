
import 'package:cinematics/ui/FavoriteDetail/FavoriteController.dart';
import 'package:cinematics/ui/FavoriteDetail/Favorites.dart';
import 'package:get/get.dart';
import '../moviepage/movies.dart';
import '../searchpage/search.dart';
import '../tvpage/television.dart';

class HomeController extends GetxController {
  var pageIndex = 0.obs;

  final pages = [const Movies(), const Televisions(), FavoriteScreen(),const Search()];

  void updatePageIndex(int value){
    pageIndex.value = value;

    if(value == 2){
      Get.find<FavoriteController>().fetchData();
    }
  }

}
