import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/app/domain/repositories/favorites_repository.dart';
import 'package:store_app/app/presentation/global/extensions/favorite_product_ext.dart';
import 'package:store_app/app/presentation/global/extensions/widgets_ext.dart';
import 'package:store_app/app/presentation/global/widgets/scaffold/state_builder_gw.dart';
import 'package:store_app/app/presentation/modules/favorites/cubit/favorites_cubit.dart';
import 'package:store_app/app/presentation/modules/favorites/cubit/favorites_state.dart';
import 'package:store_app/app/presentation/router/app_routes/product_detail_route.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavoritesCubit(context.read<FavoritesRepository>())..fetchFavorites(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Favorites')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // TODO: Implement navigation to add new favorite product
          },
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            return StateBuilderGW<FavoritesCubit, FavoritesState>(
              isLoading: (state) => state.status == FavoritesStatus.loading,
              isError: (state) => state.status == FavoritesStatus.failure,
              isEmpty: (state) =>
                  state.status == FavoritesStatus.success &&
                  state.products.isEmpty,
              loading: const CircularProgressIndicator().center,
              error: Text(
                state.errorMessage ?? 'Error loading favorites',
              ).center,
              empty: const Text('No favorite products found.').center,
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return ListTile(
                      onTap: () => GoRouter.of(context).push(
                        ProductDetailRoute.path,
                        extra: product.toProductResponse(),
                      ),
                      leading: Image.network(
                        product.image,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(product.title),
                      subtitle: Text('\$ ${product.price}'),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
