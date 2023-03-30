import 'package:cinematics/appstrings/AppConstants.dart';
import 'package:cinematics/model/TvResponse/TvResult.dart';
import 'package:cinematics/model/castResponse/Cast.dart';
import 'package:cinematics/model/movieResponse/Results.dart';
import 'package:cinematics/model/personMovieResponse/ActedInMovies.dart';
import 'package:cinematics/model/personResponse/PersonResponse.dart';
import 'package:cinematics/ui/moviedetail/MovieDetail.dart';
import 'package:cinematics/ui/tvdetail/TvDetail.dart';
import 'package:get/get.dart';

import '../../apimodule/ApiService.dart';

class PersonController extends GetxController {
  late Cast cast;
  late Results results;
  late TvResult tvResult;

  var personDetail = PersonResponse().obs;
  var movieList = RxList<ActedInMovies>();
  var tvList = RxList<ActedInMovies>();
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


  String getBackdropPath() {
    if (results != null) {
      return results.backdropPath.toString();
    } else {
      return tvResult.backdropPath.toString();
    }
  }

  void fetchData(String personId) {
    fetchPersonDetail(person, personId);
    fetchActedIn(movieCredits, personId);
    fetchActedInTvShows(tvCredits, personId);
  }

  void detailTvScreenRoute(TvResult value){
    if(onTapItem.value == true){
      onTapItem.value = false;
      Get.to( TvDetail("${DateTime.now().millisecondsSinceEpoch}"),arguments: value,fullscreenDialog: true,preventDuplicates: false);
    }
  }
}
