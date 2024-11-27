import '../../core.dart';
import '../../data.dart';

abstract interface class ProductsApi {
  Future<MyResponse<Product>> get(int id);

  Future<MyResponse<List<Product>>> list({
    String? title,
    int? price,
    int? priceMin,
    int? priceMax,
    int? categoryId,
    int? offset,
    int? limit,
  });
}
