import 'package:equatable/equatable.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  const StoreLoaded(this.products);
  final List<String> products;

  @override
  List<Object> get props => [products];

  StoreLoaded copyWith({List<String>? products}) {
    return StoreLoaded(products ?? this.products);
  }
}

class StoreError extends StoreState {
  const StoreError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
