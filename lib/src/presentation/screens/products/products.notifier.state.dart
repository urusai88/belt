part of 'products.dart';

class ProductsState {
  const ProductsState({
    required this.products,
    required this.reachLimit,
  });

  final List<Product> products;
  final bool reachLimit;
}
