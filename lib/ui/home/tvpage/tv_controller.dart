
import 'package:cinematics/appstrings/app_constants.dart';
import 'package:cinematics/model/TvResponse/TvResult.dart';
import 'package:cinematics/ui/tvdetail/tv_detail.dart';
import 'package:cinematics/util/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../apimodule/api_service.dart';



class TelevisionController extends GetxController {
  var tvAiringTodayList = <TvResult>[].obs;
  var tvOnAirList = <TvResult>[].obs;
  var tvTopRatedList = <TvResult>[].obs;
  var tvPopularList = <TvResult>[].obs;
  var isLoading = false.obs;
  var onTapItem = true.obs;
  var isLoadingPagination = false.obs;


  //pagination support for Popular TV
  var pageCountPopularTv = 1.obs;
  var controllerPopularTv = ScrollController();
  var popularTvListOffset = 0.0.obs;

  //pagination supoort for top Rated Tv
  var pageCountTopRatedTv = 1.obs;
  var controllerTopRatedTv = ScrollController();
  var topRatedTvListOffset = 0.0.obs;

  //pagination support for Tv On Air
  var pageCountTvAir = 1.obs;
  var controllerTvAir = ScrollController();
  var tvAirListOffset = 0.0.obs;

  void fetchAiringTodayTvList(String type,int pageCount) async {
    try{
      isLoading(true);
      var list = await ApiService().getTvList(type,pageCount) ;
      if(list!.isNotEmpty){
        tvAiringTodayList.assignAll(list);
      }

    }finally{
      isLoading(false);
    }
  }

  void fetchTopRatedTvList(String type,int pageCount) async {
    try{
      isLoadingPagination(true);
      var list = await ApiService().getTvList(type,pageCount) ;
      if(list!.isNotEmpty){
        if(pageCount == 1) {
          tvTopRatedList.value = list;
        }else{
          tvTopRatedList.addAll(list);
        }
      }

    }on Exception catch (_, ex){
      ex.printError();
    }finally{
      isLoadingPagination(false);
    }
  }

  void fetchPopularTvList(String type,int pageCount) async {
    try{
      isLoadingPagination(true);
      var list = await ApiService().getTvList(type,pageCount) ;
      if(list!.isNotEmpty){
        if(pageCount == 1) {
          tvPopularList.value = list;
        }else{
          tvPopularList.addAll(list);
        }
      }

    }on Exception catch (_, ex){
      ex.printError();
    }finally{
      isLoadingPagination(false);
    }
  }

  void fetchOnAirTvList(String type,int pageCount) async {
    try{
      isLoadingPagination(true);
      var list = await ApiService().getTvList(type,pageCount) ;
      if(list!.isNotEmpty){
        if(pageCount == 1) {
          tvOnAirList.value = list;
        }else{
          tvOnAirList.addAll(list);
        }
      }

    }on Exception catch (_, ex){
      ex.printError();
    }finally{
      isLoadingPagination(false);
    }
  }

  void detailScreenRoute(TvResult value,BuildContext context){
    if(onTapItem.value == true){
      onTapItem.value = false;
      //Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.tvDetail,arguments: value);
      context.pushNamed(AppRoutes.tvDetail,extra: value.toJson());
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAiringTodayTvList(airingToday,1);
    fetchTopRatedTvList(topRated,1);
    fetchPopularTvList(popular,1);
    fetchOnAirTvList(onAir,1);

    controllerPopularTv.addListener(() {
      if (controllerPopularTv.position.maxScrollExtent ==
          controllerPopularTv.offset) {
        popularTvListOffset.value = controllerPopularTv.offset;
        pageCountPopularTv++;
        fetchPopularTvList(popular,pageCountPopularTv.value);
      }
    });

    controllerTopRatedTv.addListener(() {
      if (controllerTopRatedTv.position.maxScrollExtent ==
          controllerTopRatedTv.offset) {
        topRatedTvListOffset.value = controllerTopRatedTv.offset;
        pageCountTopRatedTv++;
        fetchTopRatedTvList(popular,pageCountTopRatedTv.value);
      }
    });

    controllerTvAir.addListener(() {
      if (controllerTvAir.position.maxScrollExtent ==
          controllerTvAir.offset) {
        tvAirListOffset.value = controllerTvAir.offset;
        pageCountTvAir++;
        fetchOnAirTvList(onAir,pageCountTvAir.value);
      }
    });
  }
  @override
  void onClose() {
    super.onClose();
    controllerTvAir.dispose();
    controllerTopRatedTv.dispose();
    controllerTopRatedTv.dispose();
  }
}
