import '../../../core/typedefs.dart';
import '../../../data.dart';
import 'base.dart';

class UsersHttpApi extends HttpApi implements UsersApi {
  const UsersHttpApi({required super.tio});

  @override
  Future<MyResponse<List<User>>> list() {
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  Future<MyResponse<User>> get(int userId) {
    // TODO: implement get
    throw UnimplementedError();
  }

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

  @override
  Future<MyResponse<User>> update({
    required String name,
    required String email,
    required String password,
    required String avatarUrl,
  }) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<MyResponse<bool>> checkEmail({
    required String email,
  }) {
    // TODO: implement checkEmail
    throw UnimplementedError();
  }
}
