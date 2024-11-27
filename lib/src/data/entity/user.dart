import 'package:json_annotation/json_annotation.dart';
import 'package:tio/tio.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.role,
    required this.avatar,
  });

  factory User.fromJson(JsonMap json) => _$UserFromJson(json);

  final int id;
  final String email;
  final String name;
  final String password;
  final String role;
  final String avatar;
}
