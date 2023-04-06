import 'package:cinematics/model/searchresponse/SearchResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../apimodule/api_service.dart';
import '../../../model/TvResponse/TvResult.dart';
import '../../../model/movieResponse/Results.dart';
import '../../../util/app_routes.dart';
import '../../../util/util.dart';
import '../../moviedetail/movie_detail.dart';
import '../../tvdetail/tv_detail.dart';

class SearchController extends GetxController {
  var textFieldValue = "".obs;
  var isLoading = false.obs;
  var searchList = <SearchResult>[].obs;
  var focusNode = FocusNode();
  var onTap = false.obs;
  var pageCount = 1;
  var scrollController = ScrollController();
  var persistPosition = 0.0.obs;

  void valueChanged(String stringValue) {
    textFieldValue.value = stringValue;
  }

  void fetchTopRatedMovieList(String type, int pageCount) async {
    try {
      isLoading(true);
      var list = await ApiService().getSearchList(type, pageCount);
      if (list!.isNotEmpty) {
        if (pageCount == 1) {
          searchList.value = list;
          print("assigning");
        } else {
          searchList.addAll(list);
          print("adding");
        }

      } else {
        searchList.clear();
      }
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    debounce(
        textFieldValue,
        (_) => {
              pageCount = 1,
              fetchTopRatedMovieList(
                  textFieldValue.value.toString(), pageCount),
              focusNode.unfocus()
            });
    scrollController.addListener(() => {
          if (scrollController.position.maxScrollExtent ==
              scrollController.offset)
            {
              persistPosition.value = scrollController.offset,
              pageCount++,
              fetchTopRatedMovieList(textFieldValue.value.toString(), pageCount)
            }
        });
  }

  void detailScreen(SearchResult searchResult,BuildContext context) {
    if (searchResult.mediaType == MediaType.MOVIE) {
      Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.movieDetail,arguments: convertToMovieModel(searchResult));
    }
    //   Get.to(MovieDetail(),
    //       arguments: convertToMovieModel(searchResult),
    //       fullscreenDialog: true,
    //       preventDuplicates: false);
    // }

    if (searchResult.mediaType == MediaType.TV) {
      Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.tvDetail,arguments: convertToTvModel(searchResult));
    }
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
