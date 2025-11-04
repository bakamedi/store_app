sealed class HttpResult<T> {
  const HttpResult();
}

final class HttpSuccess<T> extends HttpResult<T> {
  const HttpSuccess(this.data);
  final T data;
}

final class HttpFailure<T> extends HttpResult<T> {
  const HttpFailure(this.message, {this.code});
  final String message;
  final int? code;
}
