// either_extensions.dart

import 'package:store_app/app/core/network/either.dart';

extension EitherX<L, R> on Either<L, R> {
  R asRight() => getRight()!;
  L asLeft() => getLeft()!;
}

extension ObjectX<T> on T {
  Right<L, T> asRight<L>() => Right<L, T>(this);
  Left<T, R> asLeft<R>() => Left<T, R>(this);
}
