import 'package:equatable/equatable.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';

enum ProductDetailStatus { initial, loading, success, failure }

class ProductDetailState extends Equatable {
  const ProductDetailState({
    this.status = ProductDetailStatus.initial,
    this.product,
    this.isFavorite = false,
  });
  final ProductDetailStatus status;
  final ProductResponse? product;
  final bool isFavorite;

  ProductDetailState copyWith({
    ProductDetailStatus? status,
    ProductResponse? product,
    bool? isFavorite,
  }) {
    return ProductDetailState(
      status: status ?? this.status,
      product: product ?? this.product,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [status, product, isFavorite];
}
