import 'package:cinematics/db/RealmInitialisation/initDb.dart';
import 'package:cinematics/model/TvResponse/TvResult.dart';
import 'package:realm/realm.dart';

part 'TelevisionResultRealm.g.dart';

@RealmModel()
class _Television {
  String? backdropPath;
  @PrimaryKey()
  int? id;
  String? name;
  String? originalLanguage;
  String? originalName;
  String? overview;
  String? posterPath;
  int? voteCount;
}

void addFavoriteShow(TvResult tvResult) {
  checkRealmAndOpen();
  var television = Television(tvResult.id,
      backdropPath: tvResult.backdropPath,
      name: tvResult.name,
      originalLanguage: tvResult.originalLanguage,
      originalName: tvResult.originalName,
      overview: tvResult.overview,
      posterPath: tvResult.posterPath,
      voteCount: tvResult.voteCount);

  realm.writeAsync(() => realm.add(television));
  print(television.name);
}

TvResult? getTvWIthId(int id) {
  checkRealmAndOpen();
  var tv = realm.find<Television>(id);
  if(tv == null){
    return null;
  }else{
    print(tv.name);
    return TvResult(
      backdropPath: tv.backdropPath,
      id: tv.id,
      name: tv.name,
      originalName: tv.originalName,
      originalLanguage: tv.originalLanguage,
      overview: tv.overview,
      posterPath: tv.posterPath
    );
  }
}

List<TvResult?> getTvListDb(){
  checkRealmAndOpen();
  var list = realm.all<Television>();

  if(list == null){
    return List.empty();
  }else{
    var tvList = <TvResult>[];
    for (var element in list) {
      tvList.add(convertDbModel(element));
    }
    print("TvList ${tvList.length}");
    return tvList;
  }
}

TvResult convertDbModel(Television tv){
  return TvResult(
      backdropPath: tv.backdropPath,
      id: tv.id,
      name: tv.name,
      originalName: tv.originalName,
      originalLanguage: tv.originalLanguage,
      overview: tv.overview,
      posterPath: tv.posterPath
  );
}