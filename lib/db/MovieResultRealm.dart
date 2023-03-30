import 'package:cinematics/model/movieResponse/Results.dart';
import 'package:realm/realm.dart';

import 'RealmInitialisation/initDb.dart';

part 'MovieResultRealm.g.dart';

@RealmModel()
class _Movie {
  bool? adult;
  String? backdropPath;
  @PrimaryKey()
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  int? voteCount;
}

void addItem(Results movieResults) {
  var movie = Movie(movieResults.id,
      adult: movieResults.adult,
      backdropPath: movieResults.backdropPath,
      originalLanguage: movieResults.originalLanguage,
      originalTitle: movieResults.originalTitle,
      overview: movieResults.overview,
      posterPath: movieResults.posterPath,
      releaseDate: movieResults.releaseDate,
      title: movieResults.title,
      video: movieResults.video,
      voteCount: movieResults.voteCount);

  checkRealmAndOpen();
  realm.writeAsync(() => realm.add(movie));
  print(movie.title);
}

Results? getMovieWithId(int movieId) {
  checkRealmAndOpen();
  var movie = realm.find<Movie>(movieId);
  if (movie == null) {
    print("null");
    return null;
  } else {
    print(movie.title);
    return Results(
        adult: movie.adult,
        backdropPath: movie.backdropPath,
        id: movie.id,
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        overview: movie.overview,
        posterPath: movie.posterPath,
        releaseDate: movie.releaseDate,
        title: movie.title,
        video: movie.video,
        voteCount: movie.voteCount);
  }
}

List<Results?> getMovieList(){
  checkRealmAndOpen();
  var list = realm.all<Movie>();
  if(list == null){
    return List.empty();
  }else{
    var movieList = <Results>[];
    for (var element in list) {
      movieList.add(convertDbModel(element));
    }
    return movieList;
  }
}

void deleteMovieFromDb(int movieId){
  checkRealmAndOpen();
  var result = realm.find<Movie>(movieId);
  if(result!=null){
    print(result.title);
    realm.writeAsync(() => realm.delete<Movie>(result));
  }
}

Results convertDbModel(Movie movie){
  return Results(
      adult: movie.adult,
      backdropPath: movie.backdropPath,
      id: movie.id,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
      overview: movie.overview,
      posterPath: movie.posterPath,
      releaseDate: movie.releaseDate,
      title: movie.title,
      video: movie.video,
      voteCount: movie.voteCount);
}



