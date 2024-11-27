import 'package:dio/dio.dart';

import '../../../core.dart';
import '../../../data.dart';
import 'base.dart';

class AuthHttpApi extends HttpApi implements AuthApi {
  const AuthHttpApi({required super.tio});

  @override
  Future<MyResponse<Tokens>> login({
    required String email,
    required String password,
  }) =>
      tio.post<Tokens>(
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
  Future<MyResponse<Tokens>> refreshToken({
    required String refreshToken,
  }) =>
      tio.post<Tokens>(
        '/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      ).one();
}
