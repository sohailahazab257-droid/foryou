import 'dart:convert';

class ProductModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final String thumbnail;
  final double price;
  final int stock;
  final double rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.thumbnail,
    required this.price,
    required this.stock,
    required this.rating,
  });
  factory ProductModel.fromjson(jsondata) {
    return ProductModel(
      id: jsondata['id'],
      title: jsondata['title'],
      description: jsondata['description'],
      category: jsondata['category'],
      thumbnail: jsondata['thumbnail'],
      price: (jsondata['price'] as num).toDouble(),
      stock: jsondata['stock'] as int,
      rating: (jsondata['rating'] as num).toDouble(),
    );
  }
}
