import 'package:equatable/equatable.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';

enum ProductDetailStatus { initial, loading, success, failure }

class ProductDetailState extends Equatable {
  const ProductDetailState({
    this.status = ProductDetailStatus.initial,
    this.product,
  });
  final ProductDetailStatus status;
  final ProductResponse? product;

  ProductDetailState copyWith({
    ProductDetailStatus? status,
    ProductResponse? product,
    String? errorMessage,
  }) {
    return ProductDetailState(
      status: status ?? this.status,
      product: product ?? this.product,
    );
  }

  @override
  List<Object?> get props => [status, product];
}
