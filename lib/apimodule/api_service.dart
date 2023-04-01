
import 'package:cinematics/environment/EnvironmentVariables.dart';
import 'package:cinematics/model/TvResponse/TvResult.dart';
import 'package:cinematics/model/castResponse/CastResponse.dart';
import 'package:cinematics/model/personMovieResponse/ActedInMovies.dart';
import 'package:cinematics/model/personMovieResponse/PersonMovieResponse.dart';
import 'package:cinematics/model/personResponse/PersonResponse.dart';
import 'package:cinematics/model/searchresponse/SearchResult.dart';
import 'package:cinematics/model/searchresponse/searchBaseResponse.dart';
import 'package:cinematics/model/youtubeModel/youtubeResponse.dart';
import 'package:cinematics/model/youtubeModel/youtubeResult.dart';
import 'package:flutter/material.dart';
import '../model/castResponse/Cast.dart';
import '../model/movieResponse/BaseResponse.dart';
import 'package:http/http.dart' as http;

import '../model/TvResponse/Response.dart';
import '../model/movieResponse/Results.dart';

class ApiService {

  final int timeOutDuration = 30;
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept-Language": "en-US",
  };


  Future<List<Results>?> getMovieList(String type,int pageCount) async {
    //replace your restFull API here.

    String url = "${EnvironmentVariables.baseUrl}movie/$type?api_key=${EnvironmentVariables.apiKey}&language=en-US&page=$pageCount";
    var uri = Uri.parse(
        url);
    debugPrint(uri.toString());
    try {
      var response = await http
          .get(uri, headers: headers)
          .timeout(Duration(seconds: timeOutDuration));

      if (response.statusCode == 200) {
        BaseResponse baseResponse = baseResponseModelFromJson(response.body);
        return baseResponse.results;
      }
    } on Exception catch (_, ex){
      debugPrint(ex.toString());
      throw "Unable to fetch data";
    }
    return null;
  }

  Future<List<Results>?> getSimilarMovieList(String type,
      String movieId) async {
    //replace your restFull API here.
    String url = "${EnvironmentVariables.baseUrl}movie/$movieId/$type?api_key=${EnvironmentVariables.apiKey}&language=en-US&page=1";
    var uri = Uri.parse(
        url);
    debugPrint(uri.toString());
    try {
      var response = await http
          .get(uri, headers: headers)
          .timeout( Duration(seconds: timeOutDuration));

      if (response.statusCode == 200) {
        BaseResponse baseResponse = baseResponseModelFromJson(response.body);
        return baseResponse.results;
      }
    } on Exception catch (_, ex){
      debugPrint(ex.toString());
      throw "Unable to fetch data";
    }
    return null;
  }

  Future<List<TvResult>?> getSimilarTvList(String type,
      String movieId) async {
    //replace your restFull API here.

    String url = "${EnvironmentVariables.baseUrl}tv/$movieId/$type?api_key=${EnvironmentVariables.apiKey}&language=en-US&page=1";
    var uri = Uri.parse(
        url);
    debugPrint(uri.toString());
    try {
      var response = await http
          .get(uri, headers: headers)
          .timeout( Duration(seconds: timeOutDuration));

      if (response.statusCode == 200) {
        Response baseResponse = responseFromJson(response.body);
        return baseResponse.results;
      }
    } on Exception catch (_, ex){
      debugPrint(ex.toString());
      throw "Unable to fetch data";
    }
    return null;
  }

  Future<List<TvResult>?> getTvList(String type,int pageCount) async {
    //replace your restFull API here.

    String url = "${EnvironmentVariables.baseUrl}tv/$type?api_key=${EnvironmentVariables.apiKey}&language=en-US&page=$pageCount";
    var uri = Uri.parse(
        url);
    debugPrint(uri.toString());
    try {
      var response = await http
          .get(uri, headers: headers)
          .timeout( Duration(seconds: timeOutDuration));

      if (response.statusCode == 200) {
        Response baseResponse = responseFromJson(response.body);
        return baseResponse.results;
      }
    } on Exception catch (_, ex){
      debugPrint(ex.toString());
      throw "Unable to fetch data";
    }
    return null;
  }

  Future<List<SearchResult>?> getSearchList(String searchQuery,int pageCount) async {
    //replace your restFull API here.

    String url = "${EnvironmentVariables.baseUrl}search/multi?api_key=${EnvironmentVariables.apiKey}&language=en-US&page=$pageCount&query=$searchQuery";
    var uri = Uri.parse(
        url);
    debugPrint(uri.toString());
    try {
      var response = await http
          .get(uri, headers: headers)
          .timeout( Duration(seconds: timeOutDuration));

      if (response.statusCode == 200) {
        SearchBaseResponse baseResponse = searchBaseResponseFromJson(
            response.body);
        return baseResponse.results;
      }
    } on Exception catch (_, ex){
      debugPrint(ex.toString());
      throw "Unable to fetch data";
    }
    return null;
  }


  Future<List<Cast>?> getCastList(String movieId, String type, String variant) async {
    //replace your restFull API here.
    String url = "${EnvironmentVariables.baseUrl}$variant/$movieId/$type?api_key=${EnvironmentVariables.apiKey}&language=en-US&page=1";
    var uri = Uri.parse(
        url);
    debugPrint(uri.toString());
    try {
      var response = await http
          .get(uri, headers: headers)
          .timeout( Duration(seconds: timeOutDuration));

      if (response.statusCode == 200) {
        CastnCrewResponse baseResponse = castNCrewResponseFromJson(
            response.body);
        return baseResponse.cast;
      }
    } on Exception catch (_, ex){
      debugPrint(ex.toString());
      throw "Unable to fetch data";
    }
    return null;
  }


Future<List<YoutubeResult>?> getYoutubeVideos(String movieId, String type, String variant) async {
  //replace your restFull API here.

  String url = "${EnvironmentVariables.baseUrl}$variant/$movieId/$type?api_key=${EnvironmentVariables.apiKey}&language=en-US";
  var uri = Uri.parse(
      url);
  debugPrint(uri.toString());
  try {
    var response = await http
        .get(uri, headers: headers)
        .timeout( Duration(seconds: timeOutDuration));

    if (response.statusCode == 200) {
      YoutubeResponse baseResponse = youtubeResponseFromJson(
          response.body);
      return baseResponse.results;
    }
  }on Exception catch (_, ex){
    debugPrint(ex.toString());
    throw "Unable to fetch data";
  }
  return null;
}

  Future<PersonResponse?> getPersonDetails(String personId, String type) async {
    //replace your restFull API here.

    String url = "${EnvironmentVariables.baseUrl}$type/$personId?api_key=${EnvironmentVariables.apiKey}&language=en-US";
    var uri = Uri.parse(
        url);
    debugPrint(uri.toString());
    try {
      var response = await http
          .get(uri, headers: headers)
          .timeout( Duration(seconds: timeOutDuration));

      if (response.statusCode == 200) {
        PersonResponse baseResponse = personResponseFromJson(
            response.body);
        return baseResponse;
      }
    } on Exception catch (_, ex){
      debugPrint(ex.toString());
      throw "Unable to fetch data";
    }
    return null;
  }

  Future<List<ActedInMovies>?> getActedIn(String personId, String type) async {
    //replace your restFull API here.

    String url = "${EnvironmentVariables.baseUrl}person/$personId/$type?api_key=${EnvironmentVariables.apiKey}&language=en-US";
    var uri = Uri.parse(
        url);
    debugPrint(uri.toString());
    try {
      var response = await http
          .get(uri, headers: headers)
          .timeout( Duration(seconds: timeOutDuration));

      if (response.statusCode == 200) {
        PersonMovieResponse baseResponse = personMovieResponseFromJson(
            response.body);
        return baseResponse.cast;
      }
    } on Exception catch (_, ex){
      debugPrint(ex.toString());
      throw "Unable to fetch data";
    }
    return null;
  }
}