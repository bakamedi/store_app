import 'package:equatable/equatable.dart';
import 'package:store_app/app/core/network/failure.dart';

abstract class ApiState<T> extends Equatable {
  const ApiState();

  @override
  List<Object?> get props => [];
}

class ApiInitial<T> extends ApiState<T> {}

class ApiLoading<T> extends ApiState<T> {}

class ApiSuccess<T> extends ApiState<T> {
  const ApiSuccess(this.data);
  final T data;

  @override
  List<Object?> get props => [data];
}

class ApiError<T> extends ApiState<T> {
  const ApiError(this.failure);
  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
