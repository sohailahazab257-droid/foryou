import 'package:foryou/helper/api.dart';

class AllCategories {
  Future<List<Map<String, String>>> get_all_categories() async {
    final List<dynamic> data = await Api().get(
      url: 'https://dummyjson.com/products/categories',
    );

    return data.map((category) {
      if (category is String) {
        return {'name': category, 'slug': category};
      }

      return {
        'name': category['name'] as String,
        'slug': category['slug'] as String,
      };
    }).toList();
  }
}
