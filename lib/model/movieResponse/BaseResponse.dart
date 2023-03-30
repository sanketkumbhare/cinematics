import 'Dates.dart';
import 'dart:convert';
import 'Results.dart';

BaseResponse baseResponseModelFromJson(String str) =>
    BaseResponse.fromJson(json.decode(str));

String passengerResponseModelToJson(BaseResponse data) =>
    json.encode(data.toJson());


class BaseResponse {
  Dates? dates;
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  BaseResponse(
      {this.dates,
      this.page,
      this.results,
      this.totalPages,
      this.totalResults});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    dates = json['dates'] != null ? Dates.fromJson(json['dates']) : null;
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dates != null) {
      data['dates'] = dates!.toJson();
    }
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

