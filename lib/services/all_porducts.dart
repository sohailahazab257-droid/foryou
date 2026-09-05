import 'package:foryou/models/product_model.dart';
import 'package:foryou/helper/api.dart';

class AllPorducts {
  Future<dynamic> get_all_products() async {
    final Map<String, dynamic> data = await Api().get(
      url: 'https://dummyjson.com/products',
    );

    final List<dynamic> products = data['products'] as List<dynamic>;
    final List<ProductModel> productList = [];
    for (final product in products) {
      productList.add(ProductModel.fromjson(product));
    }
    return productList;
  }

  Future<List<ProductModel>> get_products_by_category(String category) async {
    final Map<String, dynamic> data = await Api().get(
      url: 'https://dummyjson.com/products/category/$category',
    );

    final List<dynamic> products = data['products'] as List<dynamic>;
    return products.map((product) => ProductModel.fromjson(product)).toList();
  }
}
