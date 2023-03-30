// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MovieResultRealm.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Movie extends _Movie with RealmEntity, RealmObjectBase, RealmObject {
  Movie(
    int? id, {
    bool? adult,
    String? backdropPath,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? releaseDate,
    String? title,
    bool? video,
    int? voteCount,
  }) {
    RealmObjectBase.set(this, 'adult', adult);
    RealmObjectBase.set(this, 'backdropPath', backdropPath);
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'originalLanguage', originalLanguage);
    RealmObjectBase.set(this, 'originalTitle', originalTitle);
    RealmObjectBase.set(this, 'overview', overview);
    RealmObjectBase.set(this, 'popularity', popularity);
    RealmObjectBase.set(this, 'posterPath', posterPath);
    RealmObjectBase.set(this, 'releaseDate', releaseDate);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'video', video);
    RealmObjectBase.set(this, 'voteCount', voteCount);
  }

  Movie._();

  @override
  bool? get adult => RealmObjectBase.get<bool>(this, 'adult') as bool?;
  @override
  set adult(bool? value) => RealmObjectBase.set(this, 'adult', value);

  @override
  String? get backdropPath =>
      RealmObjectBase.get<String>(this, 'backdropPath') as String?;
  @override
  set backdropPath(String? value) =>
      RealmObjectBase.set(this, 'backdropPath', value);

  @override
  int? get id => RealmObjectBase.get<int>(this, 'id') as int?;
  @override
  set id(int? value) => RealmObjectBase.set(this, 'id', value);

  @override
  String? get originalLanguage =>
      RealmObjectBase.get<String>(this, 'originalLanguage') as String?;
  @override
  set originalLanguage(String? value) =>
      RealmObjectBase.set(this, 'originalLanguage', value);

  @override
  String? get originalTitle =>
      RealmObjectBase.get<String>(this, 'originalTitle') as String?;
  @override
  set originalTitle(String? value) =>
      RealmObjectBase.set(this, 'originalTitle', value);

  @override
  String? get overview =>
      RealmObjectBase.get<String>(this, 'overview') as String?;
  @override
  set overview(String? value) => RealmObjectBase.set(this, 'overview', value);

  @override
  double? get popularity =>
      RealmObjectBase.get<double>(this, 'popularity') as double?;
  @override
  set popularity(double? value) =>
      RealmObjectBase.set(this, 'popularity', value);

  @override
  String? get posterPath =>
      RealmObjectBase.get<String>(this, 'posterPath') as String?;
  @override
  set posterPath(String? value) =>
      RealmObjectBase.set(this, 'posterPath', value);

  @override
  String? get releaseDate =>
      RealmObjectBase.get<String>(this, 'releaseDate') as String?;
  @override
  set releaseDate(String? value) =>
      RealmObjectBase.set(this, 'releaseDate', value);

  @override
  String? get title => RealmObjectBase.get<String>(this, 'title') as String?;
  @override
  set title(String? value) => RealmObjectBase.set(this, 'title', value);

  @override
  bool? get video => RealmObjectBase.get<bool>(this, 'video') as bool?;
  @override
  set video(bool? value) => RealmObjectBase.set(this, 'video', value);

  @override
  int? get voteCount => RealmObjectBase.get<int>(this, 'voteCount') as int?;
  @override
  set voteCount(int? value) => RealmObjectBase.set(this, 'voteCount', value);

  @override
  Stream<RealmObjectChanges<Movie>> get changes =>
      RealmObjectBase.getChanges<Movie>(this);

  @override
  Movie freeze() => RealmObjectBase.freezeObject<Movie>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Movie._);
    return const SchemaObject(ObjectType.realmObject, Movie, 'Movie', [
      SchemaProperty('adult', RealmPropertyType.bool, optional: true),
      SchemaProperty('backdropPath', RealmPropertyType.string, optional: true),
      SchemaProperty('id', RealmPropertyType.int,
          optional: true, primaryKey: true),
      SchemaProperty('originalLanguage', RealmPropertyType.string,
          optional: true),
      SchemaProperty('originalTitle', RealmPropertyType.string, optional: true),
      SchemaProperty('overview', RealmPropertyType.string, optional: true),
      SchemaProperty('popularity', RealmPropertyType.double, optional: true),
      SchemaProperty('posterPath', RealmPropertyType.string, optional: true),
      SchemaProperty('releaseDate', RealmPropertyType.string, optional: true),
      SchemaProperty('title', RealmPropertyType.string, optional: true),
      SchemaProperty('video', RealmPropertyType.bool, optional: true),
      SchemaProperty('voteCount', RealmPropertyType.int, optional: true),
    ]);
  }
}
