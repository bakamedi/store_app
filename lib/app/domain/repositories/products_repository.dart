import 'package:store_app/app/core/network/failure.dart';
import 'package:store_app/app/domain/defs/type_defs.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';

abstract class ProductsRepository {
  FutureEither<Failure, List<ProductResponse>> getAll({String name = ''});
}
