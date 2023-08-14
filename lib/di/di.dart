import 'package:book_app/core/base_api.dart';
import 'package:book_app/core/book_api.dart';
import 'package:book_app/core/book_api_impl.dart';
import 'package:book_app/data/source/shpref/my_shared_pref.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.I;

void setUp() {
  di.registerLazySingleton(() => BaseApi());
  di.registerLazySingleton(() =>
      BookApiImpl(di
          .get<BaseApi>()
          .dio));
  di.registerLazySingleton(() => MySharedPref());
}