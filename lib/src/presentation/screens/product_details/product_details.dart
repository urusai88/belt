import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../domain.dart';
import '../../../presentation.dart';

part 'product_details.g.dart';

@TypedGoRoute<ProductDetailsRoute>(path: '/product/:id')
class ProductDetailsRoute extends GoRouteData {
  const ProductDetailsRoute({required this.id});

  final int id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ProductDetails(id: id);
}

class ProductDetails extends ConsumerWidget {
  const ProductDetails({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(productProvider(id));
    final title = asyncData.whenOrNull(data: (data) => data.title);

    final body = asyncData.when(
      data: (product) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: PageView(
                  children: [
                    for (final imageUrl
                        in product.images.where((e) => Uri.tryParse(e) != null))
                      Image.network(imageUrl),
                  ],
                ),
              ),
              const Gap(8),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  screenPadding,
                  0,
                  screenPadding,
                  screenPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.category.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${product.price} \u00A4',
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    Text(product.description + product.description),
                  ],
                ),
              )
            ],
          ),
        );
      },
      error: (error, __) => Center(
        child: Text('Произошла ошибка\n$error'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: title != null ? Text(title) : null,
      ),
      body: body,
    );
  }
}
