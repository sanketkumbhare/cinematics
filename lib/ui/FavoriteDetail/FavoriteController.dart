import 'package:cinematics/db/MovieResultRealm.dart';
import 'package:cinematics/model/TvResponse/TvResult.dart';
import 'package:cinematics/model/movieResponse/Results.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../db/TvResultRealm/TelevisionResultRealm.dart';
import '../moviedetail/MovieDetail.dart';
import '../tvdetail/TvDetail.dart';

class FavoriteController extends GetxController with GetSingleTickerProviderStateMixin{
  
  late TabController tabController;
  var movieList = RxList<Results?>();
  var tvList = RxList<TvResult?>();
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

  void detailTvScreenRoute(TvResult value){
    if(onTapItem.value == true){
      onTapItem.value = false;
      Get.to( TvDetail("${DateTime.now().millisecondsSinceEpoch}"),arguments: value,fullscreenDialog: true,preventDuplicates: false);
    }
  }
  void detailScreen(Results value) {
    if (onTapItem.value == true) {
      onTapItem.value = false;
      Get.to(MovieDetail("${DateTime.now().millisecondsSinceEpoch}"),
          arguments: value, fullscreenDialog: true, preventDuplicates: false);
    }
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
    dispose();
  }

}