import 'package:json_annotation/json_annotation.dart';
import 'package:tio/tio.dart';

import 'category.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  factory Product.fromJson(JsonMap json) => _$ProductFromJson(json);

  final int id;
  final String title;
  final int price;
  final String description;
  final Category category;
  final List<String> images;
}
