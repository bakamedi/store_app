import 'package:store_app/app/core/network/either.dart';

typedef Json = Map<String, dynamic>;
typedef FutureEither<L, R> = Future<Either<L, R>>;
