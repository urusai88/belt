import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tio/tio.dart';

import '../../data.dart';
import '../../services.dart';

part 'auth.state.dart';

final authProvider =
    AsyncNotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<AuthState> {
  TioStorageKey<String> get accessTokenKey =>
      ref.read(accessTokenStorageKeyProvider);

  TioStorageKey<String> get refreshTokenKey =>
      ref.read(refreshTokenStorageKeyProvider);

  @override
  FutureOr<AuthState> build() async {
    final accessToken = await accessTokenKey.get();
    final refreshToken = await refreshTokenKey.get();
    if (accessToken == null || refreshToken == null) {
      return const AuthState.guest();
    }
    try {
      final response = await ref
          .read(authApiProvider)
          .refreshToken(refreshToken: refreshToken);
      return response.when(
        success: (tokens) async {
          try {
            await accessTokenKey.set(tokens.accessToken);
            await refreshTokenKey.set(tokens.refreshToken);
            final response = await ref.read(authApiProvider).profile();
            return response.when(
              success: (user) => AuthState.user(user: user),
              failure: (_) => const AuthState.guest(),
            );
          } catch (_) {
            return const AuthState.guest();
          }
        },
        failure: (_) => const AuthState.guest(),
      );
    } catch (_) {
      return const AuthState.guest();
    }
  }

  Future<bool> authWithTokens({
    required Tokens tokens,
  }) async {
    try {
      final response = await ref
          .read(authApiProvider)
          .profile(accessToken: tokens.accessToken);
      return response.when(
        success: (user) async {
          state = AsyncValue.data(AuthState.user(user: user));
          await accessTokenKey.set(tokens.accessToken);
          await refreshTokenKey.set(tokens.refreshToken);
          return true;
        },
        failure: (error) => throw Exception(error),
      );
    } on DioException catch (_) {
      throw Exception('Ошибка соединения с сервером');
    }
  }

  Future<void> logout() async {
    await accessTokenKey.delete();
    await refreshTokenKey.delete();
    state = const AsyncValue.data(AuthState.guest());
  }
}
