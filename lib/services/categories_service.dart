import 'package:foryou/helper/api.dart';
import 'package:foryou/models/product_model.dart';

class AllPorducts {
  Future<List<dynamic>> get_all_products() async {
    final Map<String, dynamic> data = await Api().get(
      url: 'https://dummyjson.com/products',
    );
    return data['products'] as List<dynamic>;
  }
}
