// To parse this JSON data, do
//
//     final searchBaseResponse = searchBaseResponseFromJson(jsonString);

import 'dart:convert';

import 'SearchResult.dart';

SearchBaseResponse searchBaseResponseFromJson(String str) => SearchBaseResponse.fromJson(json.decode(str));

String searchBaseResponseToJson(SearchBaseResponse data) => json.encode(data.toJson());

class SearchBaseResponse {
  SearchBaseResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  List<SearchResult>? results;
  int? totalPages;
  int? totalResults;

  factory SearchBaseResponse.fromJson(Map<String, dynamic> json) => SearchBaseResponse(
    page: json["page"],
    results: json["results"] == null ? [] : List<SearchResult>.from(json["results"]!.map((x) => SearchResult.fromJson(x))),
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
