import 'package:cinematics/model/personMovieResponse/ActedInMovies.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../model/TvResponse/TvResult.dart';
import '../model/movieResponse/Results.dart';
import '../model/searchresponse/SearchResult.dart';

var tagGlobal = "";
String dateConversion(DateTime dateTime) {
  String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
  return formattedDate;
}

extension RouterContext on BuildContext{
   toNamed(String routeName, {Object? args}) =>
   Navigator.of(this).pushNamed(routeName,arguments: args);
}

Results convertToMovieModel(SearchResult searchResult) {
  return Results(
      adult: searchResult.adult,
      backdropPath: searchResult.backdropPath,
      genreIds: searchResult.genreIds,
      id: searchResult.id,
      title: searchResult.title,
      originalLanguage: searchResult.originalLanguage,
      originalTitle: searchResult.originalTitle,
      overview: searchResult.overview,
      posterPath: searchResult.posterPath);
}

TvResult convertToTvModel(SearchResult searchResult) {
  return TvResult(
      backdropPath: searchResult.backdropPath,
      genreIds: searchResult.genreIds,
      id: searchResult.id,
      originalLanguage: searchResult.originalLanguage,
      originalName: searchResult.originalName,
      overview: searchResult.overview,
      name: searchResult.name,
      posterPath: searchResult.posterPath);
}

Results convertToMovieModels(ActedInMovies searchResult) {
  return Results(
      adult: searchResult.adult,
      backdropPath: searchResult.backdropPath,
      genreIds: searchResult.genreIds,
      id: searchResult.id,
      title: searchResult.title,
      originalLanguage: searchResult.originalLanguage.toString(),
      originalTitle: searchResult.originalTitle,
      overview: searchResult.overview,
      posterPath: searchResult.posterPath);
}

TvResult convertToTvModels(ActedInMovies searchResult) {
  return TvResult(
      backdropPath: searchResult.backdropPath,
      genreIds: searchResult.genreIds,
      id: searchResult.id,
      originalLanguage: searchResult.originalLanguage.toString(),
      originalName: searchResult.originalName,
      overview: searchResult.overview,
      name: searchResult.originalName,
      posterPath: searchResult.posterPath);
}