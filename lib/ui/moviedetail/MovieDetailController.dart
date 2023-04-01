import 'package:cinematics/appstrings/AppConstants.dart';
import 'package:cinematics/model/castResponse/Cast.dart';
import 'package:cinematics/model/movieResponse/Results.dart';
import 'package:cinematics/model/youtubeModel/youtubeResult.dart';
import 'package:cinematics/ui/personDetail/PersonDetail.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../apimodule/ApiService.dart';
import '../../db/MovieResultRealm.dart';
import '../../db/RealmInitialisation/initDb.dart';
import '../home/moviepage/movie_controller.dart';
import 'MovieDetail.dart';

class MovieDetailController extends GetxController {


  late Results movieResult;

  final _similarMovieList = RxList<Results>();
  final _castList = RxList<Cast>();
  final _youtubeList = RxList<YoutubeResult>();
  var onTapItem = false.obs;
  var savedClicked = false.obs;
  var movieItem = Results().obs;


  List<Results> getSimilarMovieList(){
    return _similarMovieList;
  }

  List<Cast> getCastList(){
    return _castList;
  }

  RxList<YoutubeResult> getYoutubeList(){
    return _youtubeList;
  }

  void setArguments(){
    movieResult = Get.arguments;
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

  void routeToPersonDetail(Cast cast, Results movieResult) {
    onTapItem.value = false;
    var arguments = {"cast": cast, "movieResult": movieResult};
    Get.to(PersonDetail(), arguments: arguments);
  }

  void detailScreen(Results value) {
    if (onTapItem.value == true) {
      onTapItem.value = false;
      print("tapped");
      // dispose();
      Get.to(MovieDetail("${DateTime.now().millisecondsSinceEpoch}"),
          arguments: value, fullscreenDialog: true, preventDuplicates: false);
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
