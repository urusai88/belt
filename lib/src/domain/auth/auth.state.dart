part of 'auth.dart';

sealed class AuthState {
  const AuthState._();

  const factory AuthState.user({required User user}) = AuthUserState._;

  const factory AuthState.guest() = AuthGuestState._;
}

class AuthUserState extends AuthState {
  const AuthUserState._({required this.user}) : super._();

  final User user;
}

class AuthGuestState extends AuthState {
  const AuthGuestState._() : super._();
}
