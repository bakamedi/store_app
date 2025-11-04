import 'package:equatable/equatable.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<String> products;

  const StoreLoaded(this.products);

  @override
  List<Object> get props => [products];

  StoreLoaded copyWith({List<String>? products}) {
    return StoreLoaded(products ?? this.products);
  }
}

class StoreError extends StoreState {
  final String message;

  const StoreError(this.message);

  @override
  List<Object> get props => [message];
}
