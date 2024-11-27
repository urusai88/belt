import '../../core.dart';
import '../../data.dart';

abstract class AuthApi {
  Future<MyResponse<Tokens>> login({
    required String email,
    required String password,
  });

  Future<MyResponse<User>> profile({
    String? accessToken,
  });

  Future<MyResponse<Tokens>> refreshToken({
    required String refreshToken,
  });
}
