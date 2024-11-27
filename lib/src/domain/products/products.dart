import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tio/tio.dart';

import '../../data.dart';
import '../../services.dart';

final productsProvider = AsyncNotifierProvider<ProductsNotifier, List<Product>>(
  ProductsNotifier.new,
);

class ProductsNotifier extends AsyncNotifier<List<Product>> {
  @override
  FutureOr<List<Product>> build() {
    return ref.read(productsApiProvider).list().when(
          success: (products) => products,
          failure: (error) => throw Exception(error),
        );
  }
}
