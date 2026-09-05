import 'package:flutter/material.dart';
import 'package:foryou/home/bar.dart';
import 'package:foryou/services/all_categories.dart';
import 'package:foryou/screens/category_products.dart';
import 'package:foryou/screens/cart.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd9efff),
      appBar: AppBar(
        backgroundColor: Color(0xffd9efff),
        title: Text('Categories '),
        actions: [
          IconButton(
            tooltip: 'Cart',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Cart()),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hint: Text('Which category you need ?'),
                    prefixIcon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<dynamic>(
                  future: AllCategories().get_all_categories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<Map<String, String>> categories =
                          snapshot.data!;
                      return GridView.builder(
                        itemCount: categories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.3,
                        ),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return Card(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryProducts(
                                      categoryName: category['name']!,
                                      categorySlug: category['slug']!,
                                    ),
                                  ),
                                );
                              },
                              child: Center(child: Text(category['name']!)),
                            ),
                          );
                        },
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Failed to load products'));
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Bar(currentPage: 'categories'),
    );
  }
}
