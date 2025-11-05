import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';
import 'package:store_app/app/presentation/global/extensions/widgets_ext.dart';
import 'package:store_app/app/presentation/global/widgets/scaffold/state_builder_gw.dart';
import 'package:store_app/app/presentation/modules/product_detail/cubit/product_detail_cubit.dart';
import 'package:store_app/app/presentation/modules/product_detail/cubit/product_detail_state.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key, required this.product});
  final ProductResponse product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailCubit()..setProduct(product),
      child: const _ProductDetailContent(),
    );
  }
}

class _ProductDetailContent extends StatelessWidget {
  const _ProductDetailContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),
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
                    const SizedBox(height: 16),
                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$ ${product.price}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
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
