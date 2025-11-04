import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/app/presentation/global/widgets/scaffold/state_builder_gw.dart';
import 'package:store_app/app/presentation/modules/store/cubit/store_cubit.dart';
import 'package:store_app/app/presentation/modules/store/cubit/store_state.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  @override
  void initState() {
    super.initState();
    context.read<StoreCubit>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: StateBuilderGW<StoreCubit, StoreState>(
        isLoading: (state) => state is StoreLoading,
        isError: (state) => state is StoreError,
        isEmpty: (state) => state is StoreLoaded && state.products.isEmpty,
        loading: const Center(child: CircularProgressIndicator()),
        error: const Center(child: Text('Error loading products')),
        empty: const Center(child: Text('No products found.')),
        builder: (context, state) {
          if (state is StoreLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ListTile(
                  leading: Image.network(product.image, width: 50, height: 50),
                  title: Text(product.title),
                  subtitle: Text('\$ ${product.price}'),
                );
              },
            );
          }
          return const Center(child: Text('Welcome to the store!'));
        },
      ),
    );
  }
}
