import 'package:json_annotation/json_annotation.dart';

part 'update_user.g.dart';

@JsonSerializable()
class UpdateUserDto {
  const UpdateUserDto({
    this.email,
    this.name,
    this.password,
    this.role,
    this.avatar,
  });

  final String? email;
  final String? name;
  final String? password;
  final String? role;
  final String? avatar;
}
