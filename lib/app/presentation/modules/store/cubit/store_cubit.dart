import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/app/domain/repositories/products_repository.dart';
import 'package:store_app/app/presentation/modules/store/cubit/store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit(this._productsRepository) : super(const StoreState());
  final ProductsRepository _productsRepository;

  Future<void> fetchProducts({String name = ''}) async {
    emit(state.copyWith(status: StoreStatus.loading));
    final result = await _productsRepository.getAll(name: name);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: StoreStatus.failure,
          errorMessage: failure.toString(),
        ),
      ),
      (products) =>
          emit(state.copyWith(status: StoreStatus.success, products: products)),
    );
  }

  void startSearch() {
    emit(state.copyWith(isSearching: true));
  }

  void stopSearch() {
    emit(state.copyWith(isSearching: false));
    fetchProducts();
  }
}
