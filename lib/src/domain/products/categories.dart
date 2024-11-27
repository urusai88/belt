import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tio/tio.dart';

import '../../data.dart';
import '../../services.dart';

final categoriesProvider = FutureProvider<List<Category>>(
  (ref) => ref.read(categoriesApiProvider).list().when(
        success: (categories) => categories,
        failure: (error) => throw Exception(error),
      ),
);
