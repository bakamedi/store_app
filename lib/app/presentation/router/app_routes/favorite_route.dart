import 'package:go_router/go_router.dart';
import 'package:store_app/app/presentation/modules/favorite/view/favorite_view.dart';

class FavoriteRoute {
  static const path = '/prefs';

  static GoRoute get route {
    return GoRoute(
      path: path,
      name: path,
      builder: (context, _) => const FavoriteView(),
    );
  }
}
