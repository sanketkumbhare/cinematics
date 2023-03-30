import 'dart:convert';
import 'TvResult.dart';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  List<TvResult>? results;
  int? totalPages;
  int? totalResults;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    page: json["page"],
    results: json["results"] == null ? [] : List<TvResult>.from(json["results"]!.map((x) => TvResult.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}


