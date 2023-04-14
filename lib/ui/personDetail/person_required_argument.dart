import 'package:cinematics/model/TvResponse/TvResult.dart';
import 'package:cinematics/model/castResponse/Cast.dart';
import 'package:cinematics/model/movieResponse/Results.dart';

class RequiredArgumentPersonDetail {
  final Cast? cast;
  final TvResult? tvResult;
  final Results? results;

  RequiredArgumentPersonDetail({this.cast, this.results, this.tvResult});

  factory RequiredArgumentPersonDetail.fromJson(Map<String, dynamic> json) =>
      RequiredArgumentPersonDetail(
          cast: json["cast"],
          tvResult: json["tvResult"],
          results: json["results"]);

  Map<String, dynamic> toJson() => {
        "cast": cast,
        "tvResult": tvResult,
        "results": results,
      };
}
