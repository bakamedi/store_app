import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/app/domain/repositories/products_repository.dart';
import 'package:store_app/app/presentation/modules/store/cubit/store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit(this._productsRepository) : super(StoreInitial());
  final ProductsRepository _productsRepository;

  Future<void> fetchProducts({String name = ''}) async {
    emit(StoreLoading());
    final result = await _productsRepository.getAll(name: name);
    result.fold(
      (failure) => emit(StoreError(failure.toString())),
      (products) => emit(StoreLoaded(products)),
    );
  }
}
