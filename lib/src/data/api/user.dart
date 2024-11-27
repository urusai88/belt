import '../../core.dart';
import '../../data.dart';

abstract class UserApi {
  Future<MyResponse<List<User>>> list();

  Future<MyResponse<User>> get(int userId);

  Future<MyResponse<User>> create({
    required String name,
    required String email,
    required String password,
    required String avatarUrl,
  });

  Future<MyResponse<User>> update({
    required String name,
    required String email,
    required String password,
    required String avatarUrl,
  });

  Future<MyResponse<bool>> checkEmail({
    required String email,
  });
}
