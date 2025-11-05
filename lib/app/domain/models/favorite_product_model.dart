import 'package:equatable/equatable.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';

class FavoriteProductModel extends Equatable {
  const FavoriteProductModel({required this.product, this.customTitle});
  final ProductResponse product;
  final String? customTitle;

  @override
  List<Object?> get props => [product, customTitle];
}
