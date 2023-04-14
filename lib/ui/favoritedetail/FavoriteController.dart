
import 'package:cinematics/db/MovieResultRealm.dart';
import 'package:cinematics/model/TvResponse/TvResult.dart';
import 'package:cinematics/model/movieResponse/Results.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../db/TvResultRealm/TelevisionResultRealm.dart';
import '../../util/app_routes.dart';
import '../tvdetail/tv_detail.dart';

class FavoriteController extends GetxController with GetSingleTickerProviderStateMixin{
  
  late TabController tabController;
  var movieList = <Results?>[].obs;
  var tvList = <TvResult?>[].obs;
  var index = 0.obs;
  var onTapItem = false.obs;

  void _getMovieListDb(){
      movieList.value = getMovieList();
  }
  void _getTvList(){
    tvList.value = getTvListDb();
  }

  void onTapIndexValue(int tapIndex){
    index.value = tapIndex;
    fetchData();
  }
  void fetchData(){
    if(index.value == 0) {
      _getMovieListDb();
    }else{
      _getTvList();
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _getMovieListDb();
    _getTvList();
  }

  void detailTvScreenRoute(TvResult value,BuildContext context){
    if(onTapItem.value == true){
      onTapItem.value = false;
      context.pushNamed(AppRoutes.tvDetail,extra: value);
    }
  }
  void detailScreen(Results value, BuildContext context) {
    if (onTapItem.value == true) {
      onTapItem.value = false;
      context.pushNamed(AppRoutes.movieDetail,extra: value);
    }
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
    dispose();
  }

}