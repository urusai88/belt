import 'package:tio/tio.dart';

class JsonError {
  const JsonError({
    required this.message,
    required this.code,
  });

  final String message;
  final int code;
}

typedef MyResponse<T> = TioResponse<T, String>;
