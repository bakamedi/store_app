import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/app/domain/repositories/favorites_repository.dart';
import 'package:store_app/app/presentation/modules/favorites/cubit/favorites_state.dart';

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

  @override
  Future<void> close() {
    _favoritesSubscription?.cancel();
    return super.close();
  }
}
