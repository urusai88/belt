import '../../../core.dart';
import '../../../data.dart';
import 'base.dart';

class CategoriesHttpApi extends HttpApi implements CategoriesApi {
  CategoriesHttpApi({required super.tio});

  @override
  Future<MyResponse<Category>> get(int id) =>
      tio.get<Category>('/categories/$id').one();

  @override
  Future<MyResponse<List<Category>>> list() =>
      tio.get<Category>('/categories').many();

  @override
  Future<MyResponse<List<Product>>> products(int id) =>
      tio.get<Product>('/categories/$id/products').many();
}
