import 'package:go_router/go_router.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';
import 'package:store_app/app/presentation/modules/product_detail/view/product_detail_view.dart';

class ProductDetailRoute {
  static const path = '/product-detail';

  static GoRoute get route {
    return GoRoute(
      path: path,
      name: path,
      builder: (context, state) {
        final product = state.extra as ProductResponse;
        return ProductDetailView(product: product);
      },
    );
  }
}