import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/app/domain/repositories/favorites_repository.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';
import 'package:store_app/app/presentation/global/extensions/widgets_ext.dart';
import 'package:store_app/app/presentation/global/utils/bottom_sheet_utils.dart';
import 'package:store_app/app/presentation/global/widgets/scaffold/state_builder_gw.dart';
import 'package:store_app/app/presentation/modules/product_detail/cubit/product_detail_cubit.dart';
import 'package:store_app/app/presentation/modules/product_detail/cubit/product_detail_state.dart';
import 'package:store_app/app/presentation/modules/product_detail/view/widgets/custom_title_w.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key, required this.product});
  final ProductResponse product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailCubit(context.read<FavoritesRepository>())
            ..setProduct(product),
      child: const _ProductDetailContent(),
    );
  }
}

class _ProductDetailContent extends StatelessWidget {
  const _ProductDetailContent();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ProductDetailCubit>();
    final isFavorite = cubit.state.isFavorite;
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      builder: (context, state) {
        return StateBuilderGW<ProductDetailCubit, ProductDetailState>(
          isLoading: (state) => state.status == ProductDetailStatus.loading,
          isError: (state) => state.status == ProductDetailStatus.failure,
          loading: const CircularProgressIndicator().center,
          error: const Text('Error loading product').center,
          builder: (context, state) {
            final product = state.product;
            if (product == null) {
              return const Text('Product not found').center;
            }
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  if (isFavorite) {
                    cubit.toggleFavorite();
                  } else {
                    final customTitle = await showTextInputBottomSheet(
                      context,
                      labelText: 'Custom Title',
                      initialValue: '',
                    );
                    if (customTitle == null || customTitle.isEmpty) {
                      return;
                    }
                    cubit.toggleFavorite(customTitle: customTitle);
                  }
                },
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 300,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      background: Hero(
                        tag: product.id,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(product.image, fit: BoxFit.cover),
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black54],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTitleW(title: product.customTitle),
                          16.h,
                          Text(
                            product.title,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          16.h,
                          Row(
                            children: [
                              Text(
                                '\$ ${product.price}',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber),
                                  8.w,
                                  Text(
                                    '${product.rating.rate} (${product.rating.count} reviews)',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          16.h,
                          Text(
                            product.description,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ).padding(const EdgeInsets.all(16.0)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
