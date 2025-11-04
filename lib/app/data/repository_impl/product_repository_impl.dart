import 'package:store_app/app/core/extensions/either_ext.dart';
import 'package:store_app/app/core/network/http_client_repository.dart';
import 'package:store_app/app/core/network/failure.dart';
import 'package:store_app/app/domain/defs/type_defs.dart';
import 'package:store_app/app/domain/repositories/products_repository.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';

class ProductRepositoryImpl extends ProductsRepository {
  ProductRepositoryImpl(this._httpClient);
  final HttpClientRepository _httpClient;

  @override
  FutureEither<Failure, List<ProductResponse>> getAll({
    String name = '',
  }) async {
    final result = await _httpClient.get(
      '/products',
      converter: (data) {
        final List<dynamic> list = data as List<dynamic>;
        return list.map((item) => ProductResponse.fromJson(item)).toList();
      },
    );

    return result.fold((failure) => failure.asLeft(), (products) {
      if (name.isEmpty) {
        return products.asRight();
      } else {
        final filteredProducts = products
            .where((p) => p.title.toLowerCase().contains(name.toLowerCase()))
            .toList();
        return filteredProducts.asRight();
      }
    });
  }
}
