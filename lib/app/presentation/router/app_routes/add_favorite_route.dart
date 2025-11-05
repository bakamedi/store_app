
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/app/presentation/modules/favorites/cubit/favorites_cubit.dart';
import 'package:store_app/app/presentation/modules/favorites/view/add_favorite_view.dart';

class AddFavoriteRoute {
  static const path = '/add-favorite';

  static final route = GoRoute(
    path: path,
    builder: (context, state) {
      final favoritesCubit = state.extra as FavoritesCubit;
      return BlocProvider.value(
        value: favoritesCubit,
        child: const AddFavoriteView(),
      );
    },
  );
}
