import 'package:equatable/equatable.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<ProductResponse> products;

  const StoreLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class StoreError extends StoreState {
  final String message;

  const StoreError(this.message);

  @override
  List<Object> get props => [message];
}