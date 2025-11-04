import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/app/core/cubit/api_state.dart';
import 'package:store_app/app/core/network/http_client_repository.dart';

class ApiCubit<T> extends Cubit<ApiState<T>> {
  ApiCubit(this._httpClient) : super(ApiInitial<T>());

  final HttpClientRepository _httpClient;

  Future<void> getRequest(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(Object)? converter,
  }) async {
    emit(ApiLoading<T>());
    final result = await _httpClient.get<T>(
      path,
      queryParameters: queryParameters,
      converter: converter,
    );
    result.fold(
      (failure) => emit(ApiError<T>(failure)),
      (data) => emit(ApiSuccess<T>(data)),
    );
  }

  Future<void> postRequest(
    String path, {
    Object? body,
    T Function(Object)? converter,
  }) async {
    emit(ApiLoading<T>());
    final result = await _httpClient.post<T>(path, converter: converter);
    result.fold(
      (failure) => emit(ApiError<T>(failure)),
      (data) => emit(ApiSuccess<T>(data)),
    );
  }

  Future<void> deleteRequest(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(Object)? converter,
  }) async {
    emit(ApiLoading<T>());
    final result = await _httpClient.delete<T>(
      path,
      queryParameters: queryParameters,
      converter: converter,
    );
    result.fold(
      (failure) => emit(ApiError<T>(failure)),
      (data) => emit(ApiSuccess<T>(data)),
    );
  }
}
