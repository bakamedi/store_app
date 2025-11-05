import 'package:store_app/app/data/source/local/app_database.dart';
import 'package:store_app/app/data/source/local/favorite_products_dao.dart';
import 'package:store_app/app/domain/repositories/favorites_repository.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl(this._favoriteProductsDao);

  final FavoriteProductsDao _favoriteProductsDao;

  @override
  Stream<List<FavoriteProduct>> get allFavorites =>
      _favoriteProductsDao.watchAllFavorites();

  @override
  Future<void> addFavorite(ProductResponse product) {
    return _favoriteProductsDao.addFavorite(product);
  }

  @override
  Future<void> removeFavorite(int productId) {
    return _favoriteProductsDao.removeFavorite(productId);
  }

  @override
  Stream<bool> isFavorite(int productId) {
    return _favoriteProductsDao.isFavorite(productId);
  }
}
