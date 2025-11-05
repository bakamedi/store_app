import 'package:store_app/app/data/source/local/app_database.dart';

abstract class FavoritesRepository {
  Stream<List<FavoriteProduct>> get allFavorites;

  Stream<bool> isFavorite(int productId);

  Future<void> addFavorite(int productId);

  Future<void> removeFavorite(int productId);
}
