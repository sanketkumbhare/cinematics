import 'package:cinematics/model/personResponse/PersonResponse.dart';
import 'package:cinematics/model/searchresponse/SearchResult.dart';
import 'package:cinematics/ui/personDetail/PersonDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../apimodule/ApiService.dart';
import '../../../model/TvResponse/TvResult.dart';
import '../../../model/movieResponse/Results.dart';
import '../../moviedetail/MovieDetail.dart';
import '../../tvdetail/TvDetail.dart';

class SearchController extends GetxController {
  var textFieldValue = RxnString("");
  var isLoading = false.obs;
  var searchList = RxList<SearchResult>();
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

  void detailScreen(SearchResult searchResult) {
    if (searchResult.mediaType == MediaType.MOVIE) {
      Get.to(MovieDetail("${DateTime.now().millisecondsSinceEpoch}"),
          arguments: convertToMovieModel(searchResult),
          fullscreenDialog: true,
          preventDuplicates: false);
    }

    if (searchResult.mediaType == MediaType.TV) {
      Get.to(TvDetail("${DateTime.now().millisecondsSinceEpoch}"),
          arguments: convertToTvModel(searchResult),
          fullscreenDialog: true,
          preventDuplicates: false);
    }
  }
}

Results convertToMovieModel(SearchResult searchResult) {
  return Results(
      adult: searchResult.adult,
      backdropPath: searchResult.backdropPath,
      genreIds: searchResult.genreIds,
      id: searchResult.id,
      title: searchResult.title,
      originalLanguage: searchResult.originalLanguage,
      originalTitle: searchResult.originalTitle,
      overview: searchResult.overview,
      posterPath: searchResult.posterPath);
}

TvResult convertToTvModel(SearchResult searchResult) {
  return TvResult(
      backdropPath: searchResult.backdropPath,
      genreIds: searchResult.genreIds,
      id: searchResult.id,
      originalLanguage: searchResult.originalLanguage,
      originalName: searchResult.originalName,
      overview: searchResult.overview,
      name: searchResult.name,
      posterPath: searchResult.posterPath);
}
