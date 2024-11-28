import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:tio/tio.dart';

import '../../../core.dart';
import '../../../data.dart';
import '../../../domain.dart';
import '../../../presentation.dart';
import '../../../services.dart';

part 'products.notifier.dart';

part 'products.notifier.state.dart';

part 'products.widgets.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  void _triggerProductView(WidgetRef ref, int index) => scheduleMicrotask(
        () async =>
            ref.read(_productsProvider.notifier).triggerProductView(index),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final products = ref.watch(_productsProvider);

    final body = categories.when(
      data: (_) => CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: _Header(),
          ),
          products.when(
            skipLoadingOnRefresh: true,
            data: (products) {
              return MultiSliver(
                children: [
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        _triggerProductView(ref, index);
                        final product = products.products[index];
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => unawaited(
                            ProductDetailsRoute(id: product.id).push(context),
                          ),
                          child: _ProductTile(
                            product: product,
                          ),
                        );
                      },
                      childCount: products.products.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                    ),
                  ),
                  if (!products.reachLimit)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(screenPadding),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              );
            },
            error: (error, stackTrace) => SliverFillRemaining(
              child: Center(
                child: Text('$error'),
              ),
            ),
            loading: () => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
      error: (_, __) => Center(
        child: Text('Произошла ошибка\n${categories.error}'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Список товаров'),
        actions: [
          IconButton(
            onPressed: () => unawaited(context.push('/profile')),
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: screenPadding / 2),
        child: body,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _SearchQueryField(),
        ),
        Gap(8),
        _CategoryPicker(),
      ],
    );
  }
}

class _SearchQueryField extends ConsumerWidget {
  const _SearchQueryField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      onSubmitted: (v) => ref.read(_productScreenProvider).query = v,
      decoration: const InputDecoration(
        hintText: 'Поиск',
        isDense: true,
      ),
    );
  }
}

class _CategoryPicker extends ConsumerWidget {
  const _CategoryPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    return DropdownButton<int>(
      value: ref.watch(_productScreenProvider).categoryId,
      items: [
        const DropdownMenuItem(child: Text('Все')),
        for (final category in categories.requireValue)
          DropdownMenuItem<int>(
            value: category.id,
            child: Text(category.name),
          ),
      ],
      onChanged: (v) => ref.read(_productScreenProvider).categoryId = v,
    );
  }
}
