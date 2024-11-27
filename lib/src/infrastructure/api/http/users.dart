import '../../../core/typedefs.dart';
import '../../../data.dart';
import 'base.dart';

class UsersHttpApi extends HttpApi implements UsersApi {
  const UsersHttpApi({required super.tio});

  @override
  Future<MyResponse<User>> create({
    required String name,
    required String email,
    required String password,
    required String avatarUrl,
  }) =>
      tio.post<User>(
        '/users/',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'avatar': avatarUrl,
        },
      ).one();
}
