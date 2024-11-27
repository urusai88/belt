import '../../../core/typedefs.dart';
import '../../../data.dart';
import 'base.dart';

class ProductsHttpApi extends HttpApi implements ProductsApi {
  ProductsHttpApi({required super.tio});

  @override
  Future<MyResponse<Product>> get(int id) =>
      tio.get<Product>('/products/$id').one();

  @override
  Future<MyResponse<List<Product>>> list({
    String? title,
    int? price,
    int? priceMin,
    int? priceMax,
    int? categoryId,
    int? offset,
    int? limit,
  }) =>
      tio.get<Product>(
        '/products',
        queryParameters: {
          if (title != null) 'title': title,
          if (price != null) 'price': price,
          if (priceMin != null) 'price_min': priceMin,
          if (priceMax != null) 'price_max': priceMax,
          if (categoryId != null) 'categoryId': categoryId,
          if (offset != null) 'offset': offset,
          if (limit != null) 'limit': limit,
        },
      ).many();
}
