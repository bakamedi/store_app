import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:store_app/app/data/source/local/favorite_products_dao.dart';

part 'app_database.g.dart';

@DataClassName('FavoriteProduct')
class FavoriteProducts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer()();
}

@DriftDatabase(tables: [FavoriteProducts], daos: [FavoriteProductsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
