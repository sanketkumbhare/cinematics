import 'package:cinematics/util/app_routes.dart';
import 'package:cinematics/util/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashscreen/splashscreen.dart';

import '../home/mainhome/home.dart';

class SplashScreenApp extends StatelessWidget {
  const SplashScreenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      home: Scaffold(
        body: SplashScreen(
          seconds: 6,
          navigateAfterSeconds: Home(),
          backgroundColor: Colors.white,
          image: Image.asset(
            'assets/images/tmdb.jpg',
          ),
          loaderColor: Colors.blue,
          loadingText: const Text('Loading...'),
        ),
      ),
    );
  }
}
