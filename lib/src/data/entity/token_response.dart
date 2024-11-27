import 'package:json_annotation/json_annotation.dart';
import 'package:tio/tio.dart';

part 'token_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TokenResponse {
  const TokenResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenResponse.fromJson(JsonMap json) => _$TokenResponseFromJson(json);

  final String accessToken;
  final String refreshToken;
}
