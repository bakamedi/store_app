import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';
import 'package:store_app/app/presentation/global/extensions/widgets_ext.dart';
import 'package:store_app/app/presentation/router/app_routes/product_detail_route.dart';

class ItemStoreGW extends StatelessWidget {
  const ItemStoreGW({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onFavoritePressed,
  });

  final ProductResponse product;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: () =>
            GoRouter.of(context).push(ProductDetailRoute.path, extra: product),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12.0),
                  ),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: onFavoritePressed,
                  ),
                ),
              ],
            ).expanded,
            Text(
              product.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ).padding(const EdgeInsets.all(8.0)),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                4.h,
                Text(
                  product.rating.rate.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 12),
                ),
                const Spacer(),
                Text(
                  '\$ ${product.price}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ],
            ).padding(const EdgeInsets.symmetric(horizontal: 8.0)),
            8.h,
          ],
        ),
      ),
    );
  }
}
