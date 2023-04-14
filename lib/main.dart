// @dart=2.9
import 'package:cinematics/ui/splash/splashscreen.dart';
import 'package:cinematics/util/route_generator.dart';
import 'package:flutter/material.dart';

void main() async{
  runApp( MaterialApp.router(
    routeInformationProvider: RouteGenerator.router.routeInformationProvider,
    routeInformationParser: RouteGenerator.router.routeInformationParser,
    routerDelegate: RouteGenerator.router.routerDelegate,
  ));
}


