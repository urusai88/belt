part of 'products.dart';

final _productScreenProvider =
    ChangeNotifierProvider(ProductsScreenNotifier.new);

final _productsProvider =
    AsyncNotifierProvider<ProductsNotifier, ProductsState>(
  ProductsNotifier.new,
);

class ProductsScreenNotifier extends ChangeNotifier {
  ProductsScreenNotifier(this.ref);

  final Ref ref;

  String _query = '';
  int? _categoryId;

  String get query => _query;

  set query(String value) {
    if (_query != value) {
      _query = value;
      notifyListeners();
    }
  }

  int? get categoryId => _categoryId;

  set categoryId(int? value) {
    if (_categoryId != value) {
      _categoryId = value;
      notifyListeners();
    }
  }
}

class ProductsNotifier extends AsyncNotifier<ProductsState> {
  @override
  FutureOr<ProductsState> build() async {
    final query = ref.watch(_productScreenProvider.select((e) => e.query));
    final categoryId =
        ref.watch(_productScreenProvider.select((e) => e.categoryId));
    final response = await ref
        .read(productsApiProvider)
        .list(title: query, categoryId: categoryId, offset: 0, limit: 30);
    return response.when(
      success: (result) =>
          ProductsState(products: result, reachLimit: result.length < 30),
      failure: (failure) => throw Exception(failure),
    );
  }

  Future<void> triggerProductView(int index) async {
    if (state.isLoading || state.requireValue.reachLimit) {
      return;
    }
    if (index != state.requireValue.products.length - 1) {
      return;
    }

    state = const AsyncLoading<ProductsState>().copyWithPrevious(state);

    final query = ref.read(_productScreenProvider.select((e) => e.query));
    final categoryId =
        ref.read(_productScreenProvider.select((e) => e.categoryId));
    final response = await ref.read(productsApiProvider).list(
          title: query,
          categoryId: categoryId,
          offset: index + 1,
          limit: 30,
        );

    response.when(
      success: (result) => state = AsyncValue.data(
        ProductsState(
          products: [...state.requireValue.products, ...result],
          reachLimit: result.length < 30,
        ),
      ),
      failure: (failure) => throw Exception(failure),
    );
  }
}
