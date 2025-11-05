import 'package:equatable/equatable.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';

enum StoreStatus { initial, loading, success, failure }

class StoreState extends Equatable {
  final StoreStatus status;
  final List<ProductResponse> products;
  final String? errorMessage;
  final bool isSearching;

  const StoreState({
    this.status = StoreStatus.initial,
    this.products = const [],
    this.errorMessage,
    this.isSearching = false,
  });

  StoreState copyWith({
    StoreStatus? status,
    List<ProductResponse>? products,
    String? errorMessage,
    bool? isSearching,
  }) {
    return StoreState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage, isSearching];
}