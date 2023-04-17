import 'package:cinematics/model/searchresponse/SearchResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../apimodule/api_service.dart';
import '../../../util/app_routes.dart';
import '../../../util/util.dart';

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
        } else {
          searchList.addAll(list);
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
      context.pushNamed(AppRoutes.movieDetail,extra: convertToMovieModel(searchResult).toJson());
    }

    if (searchResult.mediaType == MediaType.TV) {
      context.pushNamed(AppRoutes.tvDetail,extra: convertToTvModel(searchResult).toJson());
    }
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
