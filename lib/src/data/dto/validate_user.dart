import 'package:json_annotation/json_annotation.dart';

part 'validate_user.g.dart';

@JsonSerializable()
class UserValidateDto {
  const UserValidateDto({
    required this.isAvailable,
  });

  final bool isAvailable;
}
