// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $productDetailsRoute,
    ];

RouteBase get $productDetailsRoute => GoRouteData.$route(
      path: '/product/:id',
      factory: $ProductDetailsRouteExtension._fromState,
    );

extension $ProductDetailsRouteExtension on ProductDetailsRoute {
  static ProductDetailsRoute _fromState(GoRouterState state) =>
      ProductDetailsRoute(
        id: int.parse(state.pathParameters['id']!),
      );

  String get location => GoRouteData.$location(
        '/product/${Uri.encodeComponent(id.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
