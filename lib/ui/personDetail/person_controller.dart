import 'package:cinematics/appstrings/app_constants.dart';
import 'package:cinematics/model/TvResponse/TvResult.dart';
import 'package:cinematics/model/castResponse/Cast.dart';
import 'package:cinematics/model/movieResponse/Results.dart';
import 'package:cinematics/model/personMovieResponse/ActedInMovies.dart';
import 'package:cinematics/model/personResponse/PersonResponse.dart';
import 'package:cinematics/ui/personDetail/person_required_argument.dart';
import 'package:cinematics/ui/tvdetail/tv_detail.dart';
import 'package:cinematics/util/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../apimodule/api_service.dart';
import '../../util/util.dart';

class PersonController extends GetxController {
  late Cast cast;
  late Results? results;
  late TvResult? tvResult;

  var personDetail = PersonResponse().obs;
  var movieList = <ActedInMovies>[].obs;
  var tvList = <ActedInMovies>[].obs;
  var onTapItem = false.obs;

  void fetchPersonDetail(String type, String movieId) async {
    try {
      var detail = await ApiService().getPersonDetails(movieId, type);
      if (detail != null) {
        personDetail.value = detail;
      }
    } finally {
      //end
      print(personDetail.value.birthday);
    }
  }

  void fetchActedIn(String type, String personId) async {
    try {
      var list = await ApiService().getActedIn(personId, type);
      if (list != null) {
        movieList.assignAll(list);
      }
    } finally {
      //end
      print(movieList.length);
    }
  }

  void fetchActedInTvShows(String type, String personId) async {
    try {
      var list = await ApiService().getActedIn(personId, type);
      if (list != null) {
        tvList.assignAll(list);
      }
    } finally {
      //end
      print(tvList.length);
    }
  }

  String? getBackdropPath() {
    if (results != null) {
      return results?.backdropPath.toString();
    } else {
      return tvResult?.backdropPath.toString();
    }
  }

  void fetchData(String personId) {
    fetchPersonDetail(person, personId);
    fetchActedIn(movieCredits, personId);
    fetchActedInTvShows(tvCredits, personId);
  }

  void detailTvScreenRoute(ActedInMovies value, BuildContext context) {
    if (onTapItem.value == true) {
      onTapItem.value = false;

      Navigator.of(context, rootNavigator: true)
          .pushNamed(AppRoutes.tvDetail, arguments: convertToTvModels(value));
    }
  }

  void detailMovieScreenRoute(ActedInMovies value, BuildContext context) {
    if (onTapItem.value == true) {
      onTapItem.value = false;
      Navigator.of(context, rootNavigator: true).pushNamed(
          AppRoutes.movieDetail,
          arguments: convertToMovieModels(value));
    }
  }

  void fetchAll(BuildContext context) {
    // cast = Get.arguments['cast'];
    RequiredArgumentPersonDetail? personDetail = ModalRoute.of(context)
        ?.settings
        .arguments as RequiredArgumentPersonDetail;
    cast = personDetail.cast!;
    results = personDetail.results; //Get.arguments['movieResult'];
    tvResult = personDetail.tvResult; //Get.arguments['tvResult'];
    fetchData(cast.id.toString());
  }
}
