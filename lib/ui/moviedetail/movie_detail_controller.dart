import 'package:cinematics/appstrings/app_constants.dart';
import 'package:cinematics/db/realminit/initDb.dart';
import 'package:cinematics/model/castResponse/Cast.dart';
import 'package:cinematics/model/movieResponse/Results.dart';
import 'package:cinematics/model/youtubeModel/youtubeResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../apimodule/api_service.dart';
import '../../db/MovieResultRealm.dart';
import '../../util/app_routes.dart';
import '../personDetail/person_required_argument.dart';

class MovieDetailController extends GetxController {
  late Results movieResult;

  MovieDetailController(this.movieResult);

  final _similarMovieList = <Results>[].obs;
  final _castList = <Cast>[].obs;
  final _youtubeList = <YoutubeResult>[].obs;
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
    //movieResult =   ModalRoute.of(context)?.settings.arguments as Results;

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

  void routeToPersonDetail(
      Cast cast, Results movieResult, BuildContext context) {
    onTapItem.value = false;
    context.pushNamed(AppRoutes.personDetail,
        extra: RequiredArgumentPersonDetail(cast: cast,results: movieResult,tvResult: null).toJson());
    //Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.personDetail,arguments: RequiredArgumentPersonDetail(cast,movieResult,null));
  }

  void detailScreen(Results value, BuildContext context) {
    if (onTapItem.value == true) {
      onTapItem.value = false;
      //Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.movieDetail,arguments: value);
      context.pushNamed(AppRoutes.movieDetail, extra: value);
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



  void disposeAll(BuildContext context) {
    disposeRealm();
    Get.delete<MovieDetailController>(tag: movieResult.id.toString());
    context.pop();
    //Navigator.of(context, rootNavigator: true).pop(context);
  }
  @override
  void onInit() {
    super.onInit();
    fetchAll(movieResult.id.toString());
  }
}
