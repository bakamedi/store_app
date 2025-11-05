import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/app/presentation/global/extensions/widgets_ext.dart';
import 'package:store_app/app/presentation/global/widgets/scaffold/state_builder_gw.dart';
import 'package:store_app/app/presentation/modules/store/cubit/store_cubit.dart';
import 'package:store_app/app/presentation/modules/store/cubit/store_state.dart';

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
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
            },
          ),
        ],
      );
    } else {
      return AppBar(
        title: const Text('Store'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<StoreCubit>().startSearch();
            },
            icon: const Icon(Icons.search),
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
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ListTile(
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
          ),
        );
      },
    );
  }
}
