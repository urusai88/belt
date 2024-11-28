part of 'products.dart';

final _productsProvider =
    AsyncNotifierProvider<ProductsNotifier, ProductsState>(
  ProductsNotifier.new,
);

final queryProvider = StateProvider((ref) => '');
final categoryIdProvider = StateProvider<int?>((ref) => null);

class ProductsNotifier extends AsyncNotifier<ProductsState> {
  @override
  FutureOr<ProductsState> build() async {
    final response = await _query(0);
    if (response.isSuccess) {
      return ProductsState(
        products: response.requireResult,
        reachLimit: response.requireResult.length < 30,
      );
    }
    throw Exception(response.requireResult);
  }

  Future<MyResponse<List<Product>>> _query(int offset) async =>
      ref.read(productsApiProvider).list(
            title: ref.read(queryProvider),
            categoryId: ref.read(categoryIdProvider),
            offset: offset,
            limit: 30,
          );

  Future<void> triggerProductView(int index) async {
    if (state.isLoading || state.requireValue.reachLimit) {
      return;
    }
    if (index != state.requireValue.products.length - 1) {
      return;
    }
    final tmp = state;
    state = const AsyncLoading<ProductsState>().copyWithPrevious(state);
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
