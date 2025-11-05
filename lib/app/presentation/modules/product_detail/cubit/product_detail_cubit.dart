import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/app/domain/repositories/favorites_repository.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';
import 'package:store_app/app/presentation/modules/product_detail/cubit/product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit(this._favoritesRepository)
    : super(const ProductDetailState());

  final FavoritesRepository _favoritesRepository;
  StreamSubscription? _favoriteSubscription;

  void setProduct(ProductResponse product) {
    emit(state.copyWith(product: product, status: ProductDetailStatus.success));
    _favoriteSubscription?.cancel();
    _favoriteSubscription = _favoritesRepository.isFavorite(product.id).listen((
      isFavorite,
    ) {
      emit(state.copyWith(isFavorite: isFavorite));
    });
  }

  Future<void> toggleFavorite() async {
    if (state.product == null) return;
    if (state.isFavorite) {
      await _favoritesRepository.removeFavorite(state.product!.id);
    } else {
      await _favoritesRepository.addFavorite(state.product!);
    }
  }

  @override
  Future<void> close() {
    _favoriteSubscription?.cancel();
    return super.close();
  }
}
