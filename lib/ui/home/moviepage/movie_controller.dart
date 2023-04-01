import 'package:cinematics/apimodule/ApiService.dart';
import 'package:cinematics/ui/moviedetail/MovieDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../appstrings/AppConstants.dart';
import '../../../model/movieResponse/Results.dart';

class MovieController extends GetxController {
  var movieNowPlayingList = <Results>[].obs;
  var movieUpcomingList = <Results>[].obs;
  var movieTopRatedList = <Results>[].obs;
  var moviePopularList = <Results>[].obs;
  var isLoading = true.obs;
  var isLoadingPagination = false.obs;
  var onTapItem = false.obs;

  //pagination support for Popular movies
  var pageCountPopularMovies = 1.obs;
  var controllerPopularMovies = ScrollController();
  var popularListOffset = 0.0.obs;

  //pagination support for TopRated Movies
  var pageCountTopMovies = 1.obs;
  var controllerTopMovies = ScrollController();
  var topMoviesListOffset = 0.0.obs;

  //pagination support for upcoming movies
  var pageCountUpcomingMovies = 1.obs;
  var controllerUpcomingMovies = ScrollController();
  var upcomingMoviesListOffset = 0.0.obs;

  void fetchNowPlayingMovieList(String type, int pageCount) async {
    try {
      isLoading(true);
      var list = await ApiService().getMovieList(type, pageCount);
      if (list!.isNotEmpty) {
        movieNowPlayingList.assignAll(list);
      }
    } finally {
      isLoading(false);
    }
  }

  void detailScreenRoute(Results value) {
    if (onTapItem.value == true) {
      onTapItem.value = false;
      String tag = "${DateTime.now().millisecondsSinceEpoch}";
      Get.to(MovieDetail(tag), arguments: value, fullscreenDialog: true);
    }
  }

  void fetchUpcomingMovieList(String type, int pageCount) async {
    try {
      isLoadingPagination(true);
      var list = await ApiService().getMovieList(type, pageCount);
      if (list!.isNotEmpty) {
        if (pageCount == 1) {
          movieUpcomingList.value = list;
        } else {
          movieUpcomingList.addAll(list);
        }
      }
    } finally {
      isLoadingPagination(false);
    }
  }

  void fetchTopRatedMovieList(String type, int pageCount) async {
    try {
      isLoadingPagination(true);
      var list = await ApiService().getMovieList(type, pageCount);
      if (list!.isNotEmpty) {
        if (pageCount == 1) {
          movieTopRatedList.value = list;
        } else {
          movieTopRatedList.addAll(list);
        }
      }
    } finally {
      isLoadingPagination(false);
    }
  }

  void fetchPopularMovieList(String type, int pageCount) async {
    try {
      isLoadingPagination(true);
      var list = await ApiService().getMovieList(type, pageCount);
      if (list!.isNotEmpty) {
        if (pageCount == 1) {
          moviePopularList.value = list;
        } else {
          moviePopularList.addAll(list);
        }
      }
    } finally {
      isLoadingPagination(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchNowPlayingMovieList(nowPlaying, 1);
    fetchPopularMovieList(popular, 1);
    fetchTopRatedMovieList(topRated, 1);
    fetchUpcomingMovieList(upcoming, 1);

    //scroll listener for Popular Movies
    controllerPopularMovies.addListener(() {
      if (controllerPopularMovies.position.maxScrollExtent ==
          controllerPopularMovies.offset) {
        popularListOffset.value = controllerPopularMovies.offset;
        pageCountPopularMovies++;
        fetchPopularMovieList(popular, pageCountPopularMovies.value);
      }
    });

    //scroll Listener for Top Rated Movies
    controllerTopMovies.addListener(() {
      if (controllerTopMovies.position.maxScrollExtent ==
          controllerTopMovies.offset) {
        topMoviesListOffset.value = controllerTopMovies.offset;
        pageCountTopMovies++;
        fetchTopRatedMovieList(topRated, pageCountTopMovies.value);
      }
    });

    // scroll Listener for Upcoming movies
    controllerUpcomingMovies.addListener(() {
      if (controllerUpcomingMovies.position.maxScrollExtent ==
          controllerUpcomingMovies.offset) {
        upcomingMoviesListOffset.value = controllerUpcomingMovies.offset;
        pageCountUpcomingMovies++;
        fetchUpcomingMovieList(upcoming, pageCountUpcomingMovies.value);
      }
    });
  }
}
