import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/app/domain/repositories/favorites_repository.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';
import 'package:store_app/app/presentation/global/extensions/widgets_ext.dart';
import 'package:store_app/app/presentation/global/utils/bottom_sheet_utils.dart';
import 'package:store_app/app/presentation/global/widgets/scaffold/state_builder_gw.dart';
import 'package:store_app/app/presentation/modules/product_detail/cubit/product_detail_cubit.dart';
import 'package:store_app/app/presentation/modules/product_detail/cubit/product_detail_state.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        actions: [
          IconButton(
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
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          ),
        ],
      ),
      body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
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
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(product.image).center,
                    16.h,
                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    8.h,
                    Text(
                      '\$ ${product.price}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    16.h,
                    Text(product.description),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
