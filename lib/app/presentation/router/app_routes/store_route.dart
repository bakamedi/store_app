import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/app/domain/repositories/products_repository.dart';
import 'package:store_app/app/presentation/modules/store/cubit/store_cubit.dart';
import 'package:store_app/app/presentation/modules/store/view/store_view.dart';

class StoreRoute {
  static const path = '/store';

  static GoRoute get route {
    return GoRoute(
      path: path,
      name: path,
      builder: (context, _) =>
          BlocProvider(
              create: (context) =>
                  StoreCubit(context.read<ProductsRepository>()),
              child: const StoreView()),
    );
  }
}
