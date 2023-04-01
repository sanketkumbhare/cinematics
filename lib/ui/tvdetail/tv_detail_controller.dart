import 'package:cinematics/db/TvResultRealm/TelevisionResultRealm.dart';
import 'package:cinematics/model/TvResponse/TvResult.dart';
import 'package:cinematics/model/youtubeModel/youtubeResult.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../apimodule/api_service.dart';
import '../../appstrings/app_constants.dart';
import '../../model/castResponse/Cast.dart';
import '../personDetail/person_detail.dart';
import 'tv_detail.dart';

class TvDetailController extends GetxController{
  late TvResult tvResult;
  var castList = RxList<Cast>();
  var youtubeList = RxList<YoutubeResult>();
  var similarTvList = RxList<TvResult>();
  var onTapItem = false.obs;
  var savedClicked = false.obs;

  get controller => null;

  void fetchCastList(String type, String movieId,String variant) async {
    try {
      var list = await ApiService().getCastList(movieId, type, variant);
      if (list!.isNotEmpty) {
        castList.assignAll(list);
      }
    } finally {
      //end
      print(castList.length);
    }
  }

  void fetchYoutubeList(String type, String movieId, String variant) async {
    try {
      var list = await ApiService().getYoutubeVideos(movieId, type, variant);
      if (list!.isNotEmpty) {
        youtubeList.assignAll(list);
      }
    } finally {
      //end
      print(youtubeList.length);
    }
  }

  void fetchSimilarTvList(String type, String movieId) async {
    try {
      var list = await ApiService().getSimilarTvList(type, movieId);
      if (list!.isNotEmpty) {
        similarTvList.assignAll(list);
      }
    } finally {
      //end
      print(similarTvList.length);
    }
  }

  void launch(String key) {
    launchUrl(Uri.parse(YOUTUBE_WATCH_BASE_URL + key.toString()));
  }

  void routeToPersonDetail(Cast cast, TvResult movieResult) {
    onTapItem.value = false;
    var arguments = {"cast": cast, "tvResult": movieResult};
    Get.to(PersonDetail(), arguments: arguments);
  }

  void addTv(TvResult tvResult){
    addFavoriteShow(tvResult);
  }

  void getTvResult(String id){
    var item = getTvWIthId(int.parse(id));
    if (item != null) {
      savedClicked.value = true;
    } else {
      savedClicked.value = false;
    }
  }

  void getArguments(){
    tvResult = Get.arguments;
    fetchAll(tvResult.id.toString());
  }

  void fetchAll(String id){
    fetchSimilarTvList(similar, id);
    fetchYoutubeList(videos, id, tv);
    fetchCastList(credits, id, tv);
    getTvResult(id);
  }

  void detailTvScreenRoute(TvResult value){
    if(onTapItem.value == true){
      onTapItem.value = false;
      Get.to( TvDetail("${DateTime.now().millisecondsSinceEpoch}"),arguments: value,fullscreenDialog: true,preventDuplicates: false);
    }
  }

}