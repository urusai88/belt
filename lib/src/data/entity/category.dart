import 'package:json_annotation/json_annotation.dart';
import 'package:tio/tio.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  const Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(JsonMap json) => _$CategoryFromJson(json);

  final int id;
  final String name;
  final Uri image;
}
