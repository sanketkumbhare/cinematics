import 'package:flutter/material.dart';
import 'package:cinematics/ui/home/mainhome/home.dart';
import 'package:cinematics/ui/splash/splashscreen.dart';
import 'package:cinematics/ui/moviedetail/movie_detail.dart';
import 'package:cinematics/ui/tvdetail/tv_detail.dart';
import 'package:cinematics/ui/personDetail/person_detail.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.personDetail:
        return MaterialPageRoute(
            builder: (context) => PersonDetail(), settings: settings);
      case AppRoutes.home:
        return MaterialPageRoute(builder: (context) => Home());
      case AppRoutes.movieDetail:
        return MaterialPageRoute(
            builder: (context) => MovieDetail(), settings: settings);
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (context) => SplashScreenApp());
      default:
        return MaterialPageRoute(builder: (context) => SplashScreenApp());
    }
  }
}
