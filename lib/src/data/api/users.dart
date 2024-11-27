import '../../core.dart';
import '../../data.dart';

abstract class UsersApi {
  Future<MyResponse<User>> create({
    required String name,
    required String email,
    required String password,
    required String avatarUrl,
  });
}
