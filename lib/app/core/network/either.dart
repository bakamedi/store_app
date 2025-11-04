// either.dart

abstract class Either<L, R> {
  const Either();

  T fold<T>(T Function(L l) leftFn, T Function(R r) rightFn);

  bool isLeft();
  bool isRight();

  L? getLeft();
  R? getRight();
}

class Left<L, R> extends Either<L, R> {
  const Left(this._value);
  final L _value;

  @override
  T fold<T>(T Function(L l) leftFn, T Function(R r) rightFn) => leftFn(_value);

  @override
  bool isLeft() => true;

  @override
  bool isRight() => false;

  @override
  L getLeft() => _value;

  @override
  R? getRight() => null;
}

class Right<L, R> extends Either<L, R> {
  const Right(this._value);
  final R _value;

  @override
  T fold<T>(T Function(L l) leftFn, T Function(R r) rightFn) => rightFn(_value);

  @override
  bool isLeft() => false;

  @override
  bool isRight() => true;

  @override
  L? getLeft() => null;

  @override
  R getRight() => _value;
}
