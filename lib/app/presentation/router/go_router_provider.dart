import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/app/domain/repositories/favorites_repository.dart';
import 'package:store_app/app/presentation/modules/favorites/cubit/favorites_cubit.dart';
import 'package:store_app/app/presentation/router/app_routes/add_favorite_route.dart';
import 'package:store_app/app/presentation/router/app_routes/favorite_route.dart';
import 'package:store_app/app/presentation/router/app_routes/favorites_list_route.dart';
import 'package:store_app/app/presentation/router/app_routes/product_detail_route.dart';
import 'package:store_app/app/presentation/router/app_routes/store_route.dart';

final goRouterProvider = GoRouter(
  initialLocation: StoreRoute.path,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider<FavoritesCubit>(
          create: (context) =>
              FavoritesCubit(context.read<FavoritesRepository>())..fetchFavorites(),
          child: child,
        );
      },
      routes: [
        StoreRoute.route,
        FavoritesListRoute.route,
        AddFavoriteRoute.route,
      ],
    ),
    FavoriteRoute.route,
    ProductDetailRoute.route,
  ],
);
