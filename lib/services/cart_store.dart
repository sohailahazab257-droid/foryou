import 'package:flutter/foundation.dart';
import 'package:foryou/models/product_model.dart';

class CartStore extends ChangeNotifier {
  CartStore._();

  static final CartStore instance = CartStore._();

  final List<ProductModel> _items = [];
  final Set<int> _favoriteIds = {};

  List<ProductModel> get items => List.unmodifiable(_items);

  Set<int> get favoriteIds => Set.unmodifiable(_favoriteIds);

  bool isFavorite(ProductModel product) => _favoriteIds.contains(product.id);

  void addToCart(ProductModel product) {
    _items.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void toggleFavorite(ProductModel product) {
    if (!_favoriteIds.add(product.id)) {
      _favoriteIds.remove(product.id);
    }
    notifyListeners();
  }
}
