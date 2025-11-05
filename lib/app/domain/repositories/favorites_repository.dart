import 'package:store_app/app/data/source/local/app_database.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';

abstract class FavoritesRepository {
  Stream<List<FavoriteProduct>> get allFavorites;

  Stream<bool> isFavorite(int productId);

  Future<void> addFavorite(ProductResponse product);

  Future<void> removeFavorite(int productId);
}
