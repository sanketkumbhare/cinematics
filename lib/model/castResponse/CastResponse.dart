import 'dart:convert';

import 'Cast.dart';

CastnCrewResponse castNCrewResponseFromJson(String str) => CastnCrewResponse.fromJson(json.decode(str));

String castNCrewResponseToJson(CastnCrewResponse data) => json.encode(data.toJson());

class CastnCrewResponse {
  CastnCrewResponse({
    this.id,
    this.cast,
    this.crew,
  });

  int? id;
  List<Cast>? cast;
  List<Cast>? crew;

  factory CastnCrewResponse.fromJson(Map<String, dynamic> json) => CastnCrewResponse(
    id: json["id"],
    cast: json["cast"] == null ? [] : List<Cast>.from(json["cast"]!.map((x) => Cast.fromJson(x))),
    crew: json["crew"] == null ? [] : List<Cast>.from(json["crew"]!.map((x) => Cast.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cast": cast == null ? [] : List<dynamic>.from(cast!.map((x) => x.toJson())),
    "crew": crew == null ? [] : List<dynamic>.from(crew!.map((x) => x.toJson())),
  };
}


