import 'package:go_router/go_router.dart';
import 'package:store_app/app/presentation/router/app_routes/add_favorite_route.dart';
import 'package:store_app/app/presentation/router/app_routes/favorite_route.dart';
import 'package:store_app/app/presentation/router/app_routes/favorites_list_route.dart';
import 'package:store_app/app/presentation/router/app_routes/product_detail_route.dart';
import 'package:store_app/app/presentation/router/app_routes/store_route.dart';

final goRouterProvider = GoRouter(
  initialLocation: StoreRoute.path,
  routes: [
    StoreRoute.route,
    FavoriteRoute.route,
    ProductDetailRoute.route,
    FavoritesListRoute.route,
    AddFavoriteRoute.route,
  ],
);
