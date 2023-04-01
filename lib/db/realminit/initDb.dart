import 'package:realm/realm.dart';

import '../MovieResultRealm.dart';
import '../TvResultRealm/TelevisionResultRealm.dart';

var config = Configuration.local([Movie.schema,Television.schema]); // create a configuration
var realm = Realm(config);

void checkRealmAndOpen() {
  if (realm.isClosed) {
    realm = Realm(config);
  }
}

void disposeRealm(){
  realm.close();
}