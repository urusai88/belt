import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tio/tio.dart';

import '../../data.dart';
import '../../services.dart';

final class MyAuthInterceptor
    extends TioAuthInterceptor<Tokens, String> {
  MyAuthInterceptor({
    required super.tio,
    required this.ref,
    required this.accessTokenKey,
    required this.refreshTokenKey,
  });

  final Ref ref;

  @override
  final TioTokenKey accessTokenKey;

  @override
  final TioTokenKey refreshTokenKey;

  @override
  TioTokenRefreshResult getRefreshTokenResult(
    TioSuccess<Tokens, String> success,
  ) =>
      TioTokenRefreshResult(
        accessToken: success.result.accessToken,
        refreshToken: success.result.refreshToken,
      );

  @override
  bool isTokenExpired(Response<dynamic> response, String error) => false;

  @override
  Future<void> onFailureRefresh(
    TioFailure<Tokens, String> failure,
  ) async {
    throw Exception('!!!!!!!!onFailureRefresh!!!!!!!!');
  }

  @override
  Future<TioResponse<Tokens, String>> refreshToken(
    String refreshToken,
  ) =>
      ref.read(authApiProvider).refreshToken(refreshToken: refreshToken);

  @override
  String buildAccessToken(String accessToken) => 'Bearer $accessToken';
}

class SecureStorageTioStorageKey implements TioStorageKey<String> {
  const SecureStorageTioStorageKey({
    required this.storage,
    required this.key,
  });

  final FlutterSecureStorage storage;
  final String key;

  @override
  Future<void> delete() => storage.delete(key: key);

  @override
  Future<String?> get({String? defaultValue}) => storage.read(key: key);

  @override
  Future<void> set(String value) => storage.write(key: key, value: value);
}
