import 'package:go_router/go_router.dart';
import 'package:store_app/app/presentation/modules/favorites/view/favorites_view.dart';

class FavoritesListRoute {
  static const path = '/favorites';

  static GoRoute get route {
    return GoRoute(
      path: path,
      name: path,
      builder: (context, state) => const FavoritesView(),
    );
  }
}
