import 'package:json_annotation/json_annotation.dart';
import 'package:tio/tio.dart';

part 'tokens.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Tokens {
  const Tokens({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Tokens.fromJson(JsonMap json) => _$TokensFromJson(json);

  final String accessToken;
  final String refreshToken;
}
