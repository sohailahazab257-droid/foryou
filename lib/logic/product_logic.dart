import 'package:foryou/models/product_model.dart';

class ProductLogic {
  static final List<dynamic> favoriteProducts = [];
  static final List<dynamic> cartProducts = [];

  static int _productId(dynamic product) {
    if (product is ProductModel) {
      return product.id;
    }
    return product['id'] as int;
  }

  static void toggleFavorite(dynamic product) {
    final index = favoriteProducts.indexWhere(
      (item) => _productId(item) == _productId(product),
    );

    if (index != -1) {
      favoriteProducts.removeAt(index);
    } else {
      favoriteProducts.add(product);
    }
  }

  static bool isFavorite(dynamic product) {
    return favoriteProducts.any(
      (item) => _productId(item) == _productId(product),
    );
  }

  static void addToCart(dynamic product) {
    final exists = cartProducts.any(
      (item) => _productId(item) == _productId(product),
    );

    if (!exists) {
      cartProducts.add(product);
    }
  }

  static bool isInCart(dynamic product) {
    return cartProducts.any((item) => _productId(item) == _productId(product));
  }
}
