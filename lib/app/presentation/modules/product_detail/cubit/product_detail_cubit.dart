import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';
import 'package:store_app/app/presentation/modules/product_detail/cubit/product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(const ProductDetailState());

  void setProduct(ProductResponse product) {
    emit(state.copyWith(status: ProductDetailStatus.success, product: product));
  }
}
