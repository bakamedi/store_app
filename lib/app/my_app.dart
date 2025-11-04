import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/app/core/network/dio_http_provider.dart';
import 'package:store_app/app/core/network/http_client_repository.dart';
import 'package:store_app/app/data/repository_impl/product_repository_impl.dart';
import 'package:store_app/app/domain/repositories/products_repository.dart';
import 'package:store_app/app/presentation/router/go_router_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Dio>(
          create: (_) => Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com')),
        ),
        RepositoryProvider<HttpClientRepository>(
          create: (context) => DioHttpProvider(dio: context.read<Dio>()),
        ),
        RepositoryProvider<ProductsRepository>(
          create: (context) =>
              ProductRepositoryImpl(context.read<HttpClientRepository>()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: goRouterProvider,
        title: 'Store App',
      ),
    );
  }
}
