import 'package:dio/dio.dart';

import '../../../core.dart';
import '../../../data.dart';
import 'base.dart';

class AuthHttpApi extends HttpApi implements AuthApi {
  const AuthHttpApi({required super.tio});

  @override
  Future<MyResponse<TokenResponse>> login({
    required String email,
    required String password,
  }) =>
      tio.post<TokenResponse>(
        '/auth/login',
        data: {'email': email, 'password': password},
      ).one();

  @override
  Future<MyResponse<User>> profile({
    String? accessToken,
  }) =>
      tio
          .get<User>(
            '/auth/profile',
            options: Options(
              headers: {
                if (accessToken != null) 'Authorization': 'Bearer $accessToken',
              },
            ),
          )
          .one();

  @override
  Future<MyResponse<TokenResponse>> refreshToken({
    required String refreshToken,
  }) =>
      tio.post<TokenResponse>(
        '/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      ).one();
}
