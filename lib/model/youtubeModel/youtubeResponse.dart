import 'dart:convert';

import 'package:cinematics/model/youtubeModel/youtubeResult.dart';

YoutubeResponse youtubeResponseFromJson(String str) => YoutubeResponse.fromJson(json.decode(str));

String youtubeResponseToJson(YoutubeResponse data) => json.encode(data.toJson());

class YoutubeResponse {
  YoutubeResponse({
    this.id,
    this.results,
  });

  int? id;
  List<YoutubeResult>? results;

  factory YoutubeResponse.fromJson(Map<String, dynamic> json) => YoutubeResponse(
    id: json["id"],
    results: json["results"] == null ? [] : List<YoutubeResult>.from(json["results"]!.map((x) => YoutubeResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

