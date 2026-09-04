class ProductLogic {
  static final List<dynamic> favoriteProducts = [];
  static final List<dynamic> cartProducts = [];

  static void toggleFavorite(dynamic product) {
    final index = favoriteProducts.indexWhere(
          (item) => item['id'] == product['id'],
    );

    if (index != -1) {
      favoriteProducts.removeAt(index);
    } else {
      favoriteProducts.add(product);
    }
  }

  static bool isFavorite(dynamic product) {
    return favoriteProducts.any(
          (item) => item['id'] == product['id'],
    );
  }

  static void addToCart(dynamic product) {
    final exists = cartProducts.any(
          (item) => item['id'] == product['id'],
    );

    if (!exists) {
      cartProducts.add(product);
    }
  }

  static bool isInCart(dynamic product) {
    return cartProducts.any(
          (item) => item['id'] == product['id'],
    );
  }
}