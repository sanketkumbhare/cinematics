// To parse this JSON data, do
//
//     final personMovieResponse = personMovieResponseFromJson(jsonString);

import 'dart:convert';

import 'ActedInMovies.dart';

PersonMovieResponse personMovieResponseFromJson(String str) => PersonMovieResponse.fromJson(json.decode(str));

String personMovieResponseToJson(PersonMovieResponse data) => json.encode(data.toJson());

class PersonMovieResponse {
  PersonMovieResponse({
    this.cast,
    this.crew,
    this.id,
  });

  List<ActedInMovies>? cast;
  List<ActedInMovies>? crew;
  int? id;

  factory PersonMovieResponse.fromJson(Map<String, dynamic> json) => PersonMovieResponse(
    cast: json["cast"] == null ? [] : List<ActedInMovies>.from(json["cast"]!.map((x) => ActedInMovies.fromJson(x))),
    crew: json["crew"] == null ? [] : List<ActedInMovies>.from(json["crew"]!.map((x) => ActedInMovies.fromJson(x))),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "cast": cast == null ? [] : List<dynamic>.from(cast!.map((x) => x.toJson())),
    "crew": crew == null ? [] : List<dynamic>.from(crew!.map((x) => x.toJson())),
    "id": id,
  };
}

