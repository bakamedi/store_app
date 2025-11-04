// data/adapters/dio_http_adapter.dart

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:store_app/app/core/network/either.dart';
import 'package:store_app/app/core/network/failure.dart';
import 'package:store_app/app/core/network/http_client_repository.dart';

class DioHttpProvider implements HttpClientRepository {
  const DioHttpProvider({required Dio dio}) : _dio = dio;
  final Dio _dio;

  @visibleForTesting
  Dio get dio => _dio;

  @override
  Future<Either<Failure, T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(Object)? converter,
    bool fastTesting = false,
  }) async {
    try {
      final res = await _dio.get(path, queryParameters: queryParameters);
      final data = converter != null ? converter(res.data) : res.data;

      return Right(data);
    } catch (e) {
      return Left(_mapError(e));
    }
  }

  @override
  Future<Either<Failure, T>> post<T>(
    String path, {
    Object? body,
    Map<String, dynamic>? headers,
    T Function(Object)? converter,
    bool fastTesting = false,
  }) async {
    try {
      final res = await _dio.post(path, data: body);

      // Validar si la respuesta contiene errores de la API
      if (_isApiErrorResponse(res.data)) {
        throw res;
      }

      final data = converter != null ? converter(res.data) : res.data;

      return Right(data);
    } catch (e) {
      return Left(_mapError(e));
    }
  }

  @override
  Future<Either<Failure, T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(Object)? converter,
    bool fastTesting = false,
  }) async {
    try {
      final res = await _dio.delete(path, queryParameters: queryParameters);
      final data = converter != null ? converter(res.data) : res.data;

      return Right(data);
    } catch (e) {
      return Left(_mapError(e));
    }
  }

  bool _isApiErrorResponse(Object? data) {
    return data is Map<String, dynamic> &&
        data.containsKey('success') &&
        data['success'] == false;
  }

  Failure _mapError(Object e) {
    if (e is DioException) {
      final statusCode = e.response?.statusCode;
      var data = e.response?.data;

      String? errorCode;
      if (data is Map<String, dynamic> && data['errorCode'] != null) {
        errorCode = data['errorCode'].toString();
      }

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return const TimeoutFailure();

        case DioExceptionType.badResponse:
          if (statusCode == 400) {
            return AuthFailure('Request inválido', errorCode: errorCode);
          } else if (statusCode == 401 || statusCode == 403) {
            return AuthFailure('No autorizado', errorCode: errorCode);
          } else if (statusCode == 422) {
            return ValidationFailure('Datos inválidos', errorCode: errorCode);
          } else if (statusCode == 404) {
            return ApiFailure(
              'Recurso no encontrado',
              statusCode: statusCode,
              errorCode: errorCode,
            );
          } else if (statusCode != null && statusCode >= 500) {
            return ApiFailure(
              'Error del servidor',
              statusCode: statusCode,
              errorCode: errorCode,
            );
          }
          return ApiFailure(
            'Error inesperado de la API',
            statusCode: statusCode,
            errorCode: errorCode,
          );

        case DioExceptionType.cancel:
          return const NetworkFailure('Solicitud cancelada por el usuario');

        case DioExceptionType.connectionError:
        case DioExceptionType.unknown:
          return NetworkFailure(
            e.message ?? 'Error de conexión desconocido',
            statusCode: statusCode,
          );

        case DioExceptionType.badCertificate:
          return const NetworkFailure('Problema con el certificado SSL');
      }
    } else if (e is Response) {
      final data = e.data;
      final errorCode = data is Map<String, dynamic> ? data['errorCode'] : null;
      return BusinessFailure('Error de la API', errorCode: errorCode);
    }

    return UnknownFailure(e.toString());
  }
}
