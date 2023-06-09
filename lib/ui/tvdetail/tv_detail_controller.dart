import 'package:cinematics/db/TvResultRealm/TelevisionResultRealm.dart';
import 'package:cinematics/model/TvResponse/TvResult.dart';
import 'package:cinematics/model/youtubeModel/youtubeResult.dart';
import 'package:cinematics/util/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../apimodule/api_service.dart';
import '../../appstrings/app_constants.dart';
import '../../model/castResponse/Cast.dart';
import '../personDetail/person_required_argument.dart';

class TvDetailController extends GetxController{
  late TvResult tvResult;
  var castList = <Cast>[].obs;
  var youtubeList = <YoutubeResult>[].obs;
  var similarTvList = <TvResult>[].obs;
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

  void routeToPersonDetail(Cast cast, TvResult movieResult, BuildContext context) {
    onTapItem.value = false;
   // var args = {"cast": cast, "tvResult": movieResult};
    Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.personDetail,arguments: RequiredArgumentPersonDetail(cast,null,tvResult));
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

  void getArguments(BuildContext context){
    tvResult = ModalRoute.of(context)?.settings.arguments as TvResult;
    fetchAll(tvResult.id.toString());
  }

  void fetchAll(String id){
    fetchSimilarTvList(similar, id);
    fetchYoutubeList(videos, id, tv);
    fetchCastList(credits, id, tv);
    getTvResult(id);
  }

  void detailTvScreenRoute(TvResult value,BuildContext context){
    if(onTapItem.value == true){
      onTapItem.value = false;
      Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.tvDetail,arguments: value);
    }
  }

}