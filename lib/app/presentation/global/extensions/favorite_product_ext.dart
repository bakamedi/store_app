import 'package:store_app/app/data/source/local/app_database.dart';
import 'package:store_app/app/domain/responses/category/category_response.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';

extension FavoriteProductX on FavoriteProduct {
  /// Convierte un [FavoriteProduct] (de base local)
  /// a un [ProductResponse] (modelo usado por la API / dominio).
  ProductResponse toProductResponse() {
    return ProductResponse(
      id: productId, // el ID real del producto original
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: RatingResponse(rate: rate, count: count),
      customTitle: customTitle,
    );
  }
}
