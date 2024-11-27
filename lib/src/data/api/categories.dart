import '../../core.dart';
import '../../data.dart';

abstract interface class CategoriesApi {
  Future<MyResponse<List<Category>>> list();

  Future<MyResponse<Category>> get(int id);

  Future<MyResponse<List<Product>>> products(int id);
}
