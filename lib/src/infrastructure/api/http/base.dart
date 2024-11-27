import 'package:tio/tio.dart';

abstract class HttpApi {
  const HttpApi({required this.tio});

  final Tio<String> tio;
}
