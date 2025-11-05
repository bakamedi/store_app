import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/app/domain/repositories/favorites_repository.dart';
import 'package:store_app/app/presentation/modules/favorites/cubit/favorites_state.dart';

import 'package:store_app/app/domain/responses/product/product_response.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._favoritesRepository) : super(const FavoritesState());

  final FavoritesRepository _favoritesRepository;
  StreamSubscription? _favoritesSubscription;

  void fetchFavorites() {
    emit(state.copyWith(status: FavoritesStatus.loading));
    _favoritesSubscription?.cancel();
    _favoritesSubscription = _favoritesRepository.allFavorites.listen(
      (products) {
        emit(
          state.copyWith(status: FavoritesStatus.success, products: products),
        );
      },
      onError: (error) {
        emit(
          state.copyWith(
            status: FavoritesStatus.failure,
            errorMessage: error.toString(),
          ),
        );
      },
    );
  }

  Future<void> addFavorite(ProductResponse product, String customTitle) async {
    try {
      await _favoritesRepository.addFavorite(product, customTitle);
    } catch (e) {
      emit(
        state.copyWith(
          status: FavoritesStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _favoritesSubscription?.cancel();
    return super.close();
  }
}
