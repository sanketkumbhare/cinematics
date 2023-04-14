import 'package:cinematics/model/TvResponse/TvResult.dart';
import 'package:cinematics/model/movieResponse/Results.dart';
import 'package:cinematics/ui/moviedetail/movie_detail_controller.dart';
import 'package:cinematics/ui/personDetail/person_controller.dart';
import 'package:cinematics/ui/tvdetail/tv_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:cinematics/ui/home/mainhome/home.dart';
import 'package:cinematics/ui/splash/splashscreen.dart';
import 'package:cinematics/ui/moviedetail/movie_detail.dart';
import 'package:cinematics/ui/tvdetail/tv_detail.dart';
import 'package:cinematics/ui/personDetail/person_detail.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../model/castResponse/Cast.dart';
import '../ui/personDetail/person_required_argument.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case AppRoutes.personDetail:
      //   return MaterialPageRoute(
      //       builder: (context) => PersonDetail(), settings: settings);
      case AppRoutes.home:
        return MaterialPageRoute(builder: (context) => Home());
      // case AppRoutes.movieDetail:
      //   return MaterialPageRoute(
      //       builder: (context) => MovieDetail(), settings: settings);
      // case AppRoutes.tvDetail:
      //   return MaterialPageRoute(
      //       builder: (context) => TvDetail(), settings: settings);
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreenApp());
      default:
        return MaterialPageRoute(builder: (context) => const SplashScreenApp());
    }
  }

  static GoRouter router = GoRouter(routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.home,
      builder: (context, state) {
        return Home();
      },
    ),
    GoRoute(
      path: '/detailMovie',
      name: AppRoutes.movieDetail,
      builder: (context, state) {
        final Results movieResult =
            Results.fromJson(state.extra as Map<String, dynamic>);
        return MovieDetail(
          controller: Get.put(MovieDetailController(movieResult),
              tag: movieResult.id.toString()),
        );
      },
    ),
    GoRoute(
        path: '/detailPerson',
        name: AppRoutes.personDetail,
        builder: (context, state) {
          final RequiredArgumentPersonDetail personDetail =
              RequiredArgumentPersonDetail.fromJson(
                  state.extra as Map<String, dynamic>);
          return PersonDetail(
              controller: Get.put(PersonController(personDetail)));
        }),
    GoRoute(
        path: '/detailTv',
        name: AppRoutes.tvDetail,
        builder: (context, state) {
          final TvResult movieResult =
              TvResult.fromJson(state.extra as Map<String, dynamic>);

          return TvDetail(
              controller: Get.put(TvDetailController(movieResult),
                  tag: movieResult.id.toString()));
        })
  ]);
}
