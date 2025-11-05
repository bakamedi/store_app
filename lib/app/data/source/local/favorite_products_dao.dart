import 'package:drift/drift.dart';
import 'package:store_app/app/data/source/local/app_database.dart';

part 'favorite_products_dao.g.dart';

@DriftAccessor(tables: [FavoriteProducts])
class FavoriteProductsDao extends DatabaseAccessor<AppDatabase>
    with _$FavoriteProductsDaoMixin {
  FavoriteProductsDao(super.db);

  Future<List<FavoriteProduct>> get allFavorites =>
      select(favoriteProducts).get();

  Stream<List<FavoriteProduct>> watchAllFavorites() =>
      select(favoriteProducts).watch();

  Future<void> addFavorite(int productId) {
    return into(
      favoriteProducts,
    ).insert(FavoriteProductsCompanion(productId: Value(productId)));
  }

  Future<void> removeFavorite(int productId) {
    return (delete(
      favoriteProducts,
    )..where((tbl) => tbl.productId.equals(productId))).go();
  }

  Stream<bool> isFavorite(int productId) {
    return (select(favoriteProducts)
          ..where((tbl) => tbl.productId.equals(productId)))
        .watchSingleOrNull()
        .map((product) => product != null);
  }
}
