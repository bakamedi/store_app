import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/app/presentation/global/extensions/widgets_ext.dart';
import 'package:store_app/app/presentation/global/widgets/custom/item_gw.dart';
import 'package:store_app/app/presentation/global/widgets/inputs/input_text_gw.dart';
import 'package:store_app/app/presentation/global/widgets/scaffold/state_builder_gw.dart';
import 'package:store_app/app/presentation/modules/store/cubit/store_cubit.dart';
import 'package:store_app/app/presentation/modules/store/cubit/store_state.dart';
import 'package:store_app/app/presentation/modules/favorites/cubit/favorites_cubit.dart';
import 'package:store_app/app/presentation/modules/favorites/cubit/favorites_state.dart';
import 'package:store_app/app/presentation/router/app_routes/favorites_list_route.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<StoreCubit>().fetchProducts();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<StoreCubit>().fetchProducts(name: _searchController.text);
    });
  }

  AppBar _buildAppBar(BuildContext context, StoreState state) {
    if (state.isSearching) {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _searchController.clear();
            context.read<StoreCubit>().stopSearch();
          },
        ),
        title: InputTextGW(controller: _searchController),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => _searchController.clear(),
          ),
        ],
      );
    } else {
      return AppBar(
        title: const Text('Store'),
        actions: [
          IconButton(
            onPressed: () => context.read<StoreCubit>().startSearch(),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => GoRouter.of(context).push(FavoritesListRoute.path),
            icon: const Icon(Icons.favorite),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context, state),
          body: StateBuilderGW<StoreCubit, StoreState>(
            isLoading: (state) => state.status == StoreStatus.loading,
            isError: (state) => state.status == StoreStatus.failure,
            isEmpty: (state) =>
                state.status == StoreStatus.success && state.products.isEmpty,
            loading: const CircularProgressIndicator().center,
            error: Text(state.errorMessage ?? 'Error loading products').center,
            empty: const Text('No products found.').center,
            builder: (context, state) {
              return GridView.builder(
                padding: const EdgeInsets.all(17.0),
                itemCount: state.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return BlocBuilder<FavoritesCubit, FavoritesState>(
                    builder: (context, favoritesState) {
                      final isFavorite = favoritesState.products.any(
                        (favProduct) => favProduct.id == product.id,
                      );
                      return ItemStoreGW(
                        product: product,
                        isFavorite: isFavorite,
                        onFavoritePressed: () {
                          if (isFavorite) {
                            context.read<FavoritesCubit>().removeFavorite(
                              product.id,
                            );
                          } else {
                            context.read<FavoritesCubit>().addFavorite(
                              product,
                              product.title,
                            );
                          }
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
