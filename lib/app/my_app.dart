import 'package:flutter/material.dart';
import 'package:store_app/app/presentation/router/go_router_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouterProvider,
      themeMode: ThemeMode.system,
      title: 'Store App',
    );
  }
}
