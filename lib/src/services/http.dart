import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tio/tio.dart';

import '../core/tio/auth_interceptor.dart';
import '../data.dart';
import 'storage.dart';

final dioBaseUrlProvider =
    Provider<String>((ref) => throw UnimplementedError());

final accessTokenStorageKeyProvider = Provider<TioTokenKey>(
  (ref) => SecureStorageTioStorageKey(
    storage: ref.read(secureStorageProvider),
    key: 'access_token',
  ),
);

final refreshTokenStorageKeyProvider = Provider<TioTokenKey>(
  (ref) => SecureStorageTioStorageKey(
    storage: ref.read(secureStorageProvider),
    key: 'refresh_token',
  ),
);

final dioProvider = Provider(
  (ref) => Dio(BaseOptions(baseUrl: ref.read(dioBaseUrlProvider)))
    ..interceptors.add(LogInterceptor(responseBody: true, requestHeader: true)),
);

final tioProvider = Provider(
  (ref) => Tio<String>.withInterceptors(
    dio: ref.read(dioProvider),
    factoryConfig: TioFactoryConfig(
      jsonFactories: {
        TokenResponse.fromJson,
        User.fromJson,
      },
      errorStringFactory: (s) => s,
      errorJsonFactory: (json) {
        if (json.containsKey('message')) {
          var message = json['message'];
          if (message is List) {
            message = message.join(', ');
          }
          return '$message';
        }
        return '$json';
      },
    ),
    builders: [
      (tio) => MyAuthInterceptor(
            tio: tio,
            ref: ref,
            accessTokenKey: ref.read(accessTokenStorageKeyProvider),
            refreshTokenKey: ref.read(refreshTokenStorageKeyProvider),
          ),
    ],
  ),
);

final authApiProvider = Provider<AuthApi>((ref) => throw UnimplementedError());

final userApiProvider = Provider<UserApi>((ref) => throw UnimplementedError());
