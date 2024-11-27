import 'package:json_annotation/json_annotation.dart';

part 'create_user.g.dart';

@JsonSerializable()
class CreateUserDto {
  const CreateUserDto({
    required this.email,
    required this.name,
    required this.password,
    required this.role,
    required this.avatar,
  });

  final String email;
  final String name;
  final String password;
  final String role;
  final String avatar;
}
