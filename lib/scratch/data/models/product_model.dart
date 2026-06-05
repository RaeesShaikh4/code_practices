import '../../domain/entities/product_entity.dart';

// Data model: handles JSON parsing and maps to domain entity
class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double ratingRate;
  final int ratingCount;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.ratingRate,
    required this.ratingCount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final rating = json['rating'] as Map<String, dynamic>;
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      ratingRate: (rating['rate'] as num).toDouble(),
      ratingCount: rating['count'] as int,
    );
  }

  ProductEntity toEntity() => ProductEntity(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category,
        image: image,
        rating: ratingRate,
        ratingCount: ratingCount,
      );
}
