import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data.dart';
import '../../services.dart';

final productProvider = FutureProviderFamily<Product, int>((ref, id) async {
  return ref.read(productsApiProvider).get(id).then(
        (response) => response.when(
          success: (product) => product,
          failure: (error) => throw Exception(error),
        ),
      );
});
