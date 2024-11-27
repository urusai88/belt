import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'src/infrastructure.dart';
import 'src/presentation.dart';
import 'src/services.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [
        dioBaseUrlProvider.overrideWithValue('https://api.escuelajs.co/api/v1'),
        authApiProvider
            .overrideWith((ref) => AuthHttpApi(tio: ref.read(tioProvider))),
        categoriesApiProvider.overrideWith(
          (ref) => CategoriesHttpApi(tio: ref.read(tioProvider)),
        ),
        productsApiProvider
            .overrideWith((ref) => ProductsHttpApi(tio: ref.read(tioProvider))),
        usersApiProvider
            .overrideWith((ref) => UsersHttpApi(tio: ref.read(tioProvider))),
      ],
      child: const MyApp(),
    ),
  );
}

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const LoadingScreen()),
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
    GoRoute(path: '/products', builder: (_, __) => const ProductsScreen()),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      builder: (context, child) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: child,
        );
      },
    );
  }
}
