import 'package:drift/drift.dart';
import 'package:store_app/app/data/source/local/app_database.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';

part 'favorite_products_dao.g.dart';

@DriftAccessor(tables: [FavoriteProducts])
class FavoriteProductsDao extends DatabaseAccessor<AppDatabase>
    with _$FavoriteProductsDaoMixin {
  FavoriteProductsDao(super.db);

  Future<List<FavoriteProduct>> get allFavorites =>
      select(favoriteProducts).get();

  Stream<List<FavoriteProduct>> watchAllFavorites() =>
      select(favoriteProducts).watch();

  Future<void> addFavorite(ProductResponse productResp, String customTitle) {
    return into(favoriteProducts).insert(
      FavoriteProductsCompanion(
        customTitle: Value(customTitle),
        image: Value(productResp.image),
        description: Value(productResp.description),
        price: Value(productResp.price),
        title: Value(productResp.title),
        productId: Value(productResp.id),
        category: Value(productResp.category),
        count: Value(productResp.rating.count),
        rate: Value(productResp.rating.rate),
      ),
    );
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
