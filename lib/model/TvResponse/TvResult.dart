class TvResult {
  TvResult({
    this.backdropPath,
    this.genreIds,
    this.id,
    this.name,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.posterPath,
    this.voteCount,
  });

  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? name;
  String? originalLanguage;
  String? originalName;
  String? overview;
  String? posterPath;
  int? voteCount;

  factory TvResult.fromJson(Map<String, dynamic> json) => TvResult(
    backdropPath: json["backdrop_path"],
    genreIds: json["genre_ids"] == null ? [] : List<int>.from(json["genre_ids"]!.map((x) => x)),
    id: json["id"],
    name: json["name"],
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "genre_ids": genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
    "id": id,
    "name": name,
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "poster_path": posterPath,
    "vote_count": voteCount,
  };
}