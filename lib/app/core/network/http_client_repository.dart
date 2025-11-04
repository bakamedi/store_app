import 'package:store_app/app/core/network/either.dart';
import 'package:store_app/app/core/network/failure.dart';

abstract class HttpClientRepository {
  Future<Either<Failure, T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(Object)? converter,
  });

  Future<Either<Failure, T>> post<T>(
    String path, {
    Object body,
    Map<String, dynamic>? headers,
    T Function(Object)? converter,
  });

  Future<Either<Failure, T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(Object)? converter,
  });

  // Puedes agregar put, etc.
}
