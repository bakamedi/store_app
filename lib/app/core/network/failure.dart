sealed class Failure {
  const Failure(this.message);
  final String message;
}

/// Problemas de red como no hay conexión, timeout, etc.
final class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {this.statusCode});
  final int? statusCode;
}

/// Error desconocido (por ejemplo, un error no controlado)
final class UnknownFailure extends Failure {
  const UnknownFailure(super.message, {this.errorCode});
  final String? errorCode;
}

/// Errores relacionados a la API como respuesta inesperada o malformada
final class ApiFailure extends Failure {
  const ApiFailure(super.message, {this.statusCode, this.errorCode});
  final int? statusCode;
  final String? errorCode;
}

/// Error de autenticación: token inválido, expirado, no autorizado
final class AuthFailure extends Failure {
  const AuthFailure(super.message, {this.errorCode});
  final String? errorCode;
}

/// Errores del lado del usuario, como input inválido
final class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {this.field, this.errorCode});
  final String? field;
  final String? errorCode;
}

/// Errores relacionados con la lógica de negocio (por ejemplo, usuario ya existe)
final class BusinessFailure extends Failure {
  const BusinessFailure(super.message, {this.errorCode});
  final String? errorCode;
}

/// Cuando no hay datos que mostrar (vacío válido, no error grave)
final class NoDataFailure extends Failure {
  const NoDataFailure([super.message = 'No data available']);
}

/// Fallo por timeout (específicamente)
final class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'Request timed out']);
}

/// Fallos relacionados con almacenamiento local o cache
final class StorageFailure extends Failure {
  const StorageFailure(super.message);
}
