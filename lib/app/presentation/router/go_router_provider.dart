import 'package:go_router/go_router.dart';
import 'package:store_app/app/presentation/router/app_routes/store_route.dart';

final goRouterProvider = GoRouter(
  initialLocation: StoreRoute.path,
  routes: [StoreRoute.route],
);
