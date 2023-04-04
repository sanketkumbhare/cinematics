import 'package:cinematics/appstrings/app_constants.dart';
import 'package:cinematics/model/castResponse/Cast.dart';
import 'package:cinematics/model/movieResponse/Results.dart';
import 'package:cinematics/model/youtubeModel/youtubeResult.dart';
import 'package:cinematics/ui/personDetail/person_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../apimodule/api_service.dart';
import '../../db/MovieResultRealm.dart';
import '../../db/realminit/initDb.dart';
import '../../util/app_routes.dart';
import '../personDetail/person_required_argument.dart';
import 'movie_detail.dart';

class MovieDetailController extends GetxController {
  late Results movieResult;

  final _similarMovieList = RxList<Results>();
  final _castList = RxList<Cast>();
  final _youtubeList = RxList<YoutubeResult>();
  var onTapItem = false.obs;
  var savedClicked = false.obs;
  var movieItem = Results().obs;

  List<Results> getSimilarMovieList() {
    return _similarMovieList;
  }

  List<Cast> getCastList() {
    return _castList;
  }

  RxList<YoutubeResult> getYoutubeList() {
    return _youtubeList;
  }

  void setArguments(BuildContext context) {
    movieResult =   ModalRoute.of(context)?.settings.arguments as Results;
    fetchAll(movieResult.id.toString());
  }

  void fetchSimilarMovieList(String type, String movieId) async {
    try {
      var list = await ApiService().getSimilarMovieList(type, movieId);
      if (list!.isNotEmpty) {
        _similarMovieList.assignAll(list);
      }
    } finally {
      //end
      print(_similarMovieList.length);
    }
  }

  void fetchCastList(String type, String movieId, String variant) async {
    try {
      var list = await ApiService().getCastList(movieId, type, variant);
      if (list!.isNotEmpty) {
        _castList.assignAll(list);
      }
    } finally {
      //end
      print(_castList.length);
    }
  }

  void fetchYoutubeList(String type, String movieId, String variant) async {
    try {
      var list = await ApiService().getYoutubeVideos(movieId, type, variant);
      if (list!.isNotEmpty) {
        _youtubeList.assignAll(list);
      }
    } finally {
      //end
      print(_youtubeList.length);
    }
  }

  void fetchAll(String movieId) {
    fetchYoutubeList(videos, movieId, movie);
    fetchSimilarMovieList(similar, movieId);
    fetchCastList(credits, movieId, movie);
    getMovieFromDb(int.parse(movieId));
  }

  void launch(String key) {
    launchUrl(Uri.parse(YOUTUBE_WATCH_BASE_URL + key.toString()));
  }

  void routeToPersonDetail(Cast cast, Results movieResult,BuildContext context) {
    onTapItem.value = false;
    Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.personDetail,arguments: RequiredArgumentPersonDetail(cast,movieResult,null));
  }

  void detailScreen(Results value,BuildContext context) {
    if (onTapItem.value == true) {
      onTapItem.value = false;
      print("tapped");
      // dispose();
      Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.movieDetail,arguments: value);
      // Get.to(MovieDetail(),
      //     arguments: value, fullscreenDialog: true, preventDuplicates: false);
    }
  }

  void getMovieFromDb(int movieId) {
    var item = getMovieWithId(movieId);
    if (item != null) {
      savedClicked.value = true;
    } else {
      savedClicked.value = false;
    }
  }

  void deleteMovie(int movieId) {
    deleteMovieFromDb(movieId);
  }

  void addMovie(Results movieResults) {
    addItem(movieResults);
  }

  @override
  void onClose() {
    super.onClose();
    disposeRealm();
  }
}
