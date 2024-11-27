import '../../core.dart';
import '../../data.dart';

abstract class AuthApi {
  Future<MyResponse<TokenResponse>> login({
    required String email,
    required String password,
  });

  Future<MyResponse<User>> profile({
    String? accessToken,
  });

  Future<MyResponse<TokenResponse>> refreshToken({
    required String refreshToken,
  });
}
