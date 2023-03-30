// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TelevisionResultRealm.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Television extends _Television
    with RealmEntity, RealmObjectBase, RealmObject {
  Television(
    int? id, {
    String? backdropPath,
    String? name,
    String? originalLanguage,
    String? originalName,
    String? overview,
    String? posterPath,
    int? voteCount,
  }) {
    RealmObjectBase.set(this, 'backdropPath', backdropPath);
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'originalLanguage', originalLanguage);
    RealmObjectBase.set(this, 'originalName', originalName);
    RealmObjectBase.set(this, 'overview', overview);
    RealmObjectBase.set(this, 'posterPath', posterPath);
    RealmObjectBase.set(this, 'voteCount', voteCount);
  }

  Television._();

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
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get originalLanguage =>
      RealmObjectBase.get<String>(this, 'originalLanguage') as String?;
  @override
  set originalLanguage(String? value) =>
      RealmObjectBase.set(this, 'originalLanguage', value);

  @override
  String? get originalName =>
      RealmObjectBase.get<String>(this, 'originalName') as String?;
  @override
  set originalName(String? value) =>
      RealmObjectBase.set(this, 'originalName', value);

  @override
  String? get overview =>
      RealmObjectBase.get<String>(this, 'overview') as String?;
  @override
  set overview(String? value) => RealmObjectBase.set(this, 'overview', value);

  @override
  String? get posterPath =>
      RealmObjectBase.get<String>(this, 'posterPath') as String?;
  @override
  set posterPath(String? value) =>
      RealmObjectBase.set(this, 'posterPath', value);

  @override
  int? get voteCount => RealmObjectBase.get<int>(this, 'voteCount') as int?;
  @override
  set voteCount(int? value) => RealmObjectBase.set(this, 'voteCount', value);

  @override
  Stream<RealmObjectChanges<Television>> get changes =>
      RealmObjectBase.getChanges<Television>(this);

  @override
  Television freeze() => RealmObjectBase.freezeObject<Television>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Television._);
    return const SchemaObject(
        ObjectType.realmObject, Television, 'Television', [
      SchemaProperty('backdropPath', RealmPropertyType.string, optional: true),
      SchemaProperty('id', RealmPropertyType.int,
          optional: true, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('originalLanguage', RealmPropertyType.string,
          optional: true),
      SchemaProperty('originalName', RealmPropertyType.string, optional: true),
      SchemaProperty('overview', RealmPropertyType.string, optional: true),
      SchemaProperty('posterPath', RealmPropertyType.string, optional: true),
      SchemaProperty('voteCount', RealmPropertyType.int, optional: true),
    ]);
  }
}
