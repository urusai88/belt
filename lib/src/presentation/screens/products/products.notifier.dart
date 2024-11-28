part of 'products.dart';

final _productScreenProvider =
    ChangeNotifierProvider((ref) => ProductsScreenNotifier());

final _productsProvider =
    AsyncNotifierProvider<ProductsNotifier, ProductsState>(
  ProductsNotifier.new,
);

class ProductsScreenNotifier extends ChangeNotifier {
  String get query => _query;
  String _query = '';

  set query(String value) {
    if (_query != value) {
      _query = value;
      notifyListeners();
    }
  }

  int? get categoryId => _categoryId;
  int? _categoryId;

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
    final query = ref.watch(
      _productScreenProvider.select((e) => e.query),
    );
    final categoryId = ref.watch(
      _productScreenProvider.select((e) => e.categoryId),
    );
    final response = await _query(0);
    if (response.isSuccess) {
      return ProductsState(
        products: response.requireResult,
        reachLimit: response.requireResult.length < 30,
      );
    }
    throw Exception(response.requireResult);
  }

  Future<MyResponse<List<Product>>> _query(int offset) async {
    final query = ref.read(
      _productScreenProvider.select((e) => e.query),
    );
    final categoryId = ref.read(
      _productScreenProvider.select((e) => e.categoryId),
    );
    return ref
        .read(productsApiProvider)
        .list(title: query, categoryId: categoryId, offset: offset, limit: 30);
  }

  Future<void> triggerProductView(int index) async {
    if (state.isLoading || state.requireValue.reachLimit) {
      return;
    }
    if (index != state.requireValue.products.length - 1) {
      return;
    }
    final tmp = state;
    state = const AsyncLoading<ProductsState>().copyWithPrevious(state);

    final query = ref.read(
      _productScreenProvider.select((e) => e.query),
    );
    final categoryId = ref.read(
      _productScreenProvider.select((e) => e.categoryId),
    );
    try {
      final response = await _query(index + 1);
      if (response.isSuccess) {
        state = AsyncValue.data(
          ProductsState(
            products: [
              ...state.requireValue.products,
              ...response.requireResult,
            ],
            reachLimit: response.requireResult.length < 30,
          ),
        );
      } else {
        state = tmp;
      }
    } catch (e, s) {
      print('$e\n$s');
      state = tmp;
    }
  }
}
