import 'package:equatable/equatable.dart';
import 'package:store_app/app/data/source/local/app_database.dart';

enum FavoritesStatus { initial, loading, success, failure }

class FavoritesState extends Equatable {
  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.products = const [],
    this.errorMessage,
  });
  final FavoritesStatus status;
  final List<FavoriteProduct> products;
  final String? errorMessage;

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<FavoriteProduct>? products,
    String? errorMessage,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage];
}
