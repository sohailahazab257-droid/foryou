import 'package:flutter/material.dart';
import 'package:foryou/screens/favorit.dart';
import 'package:foryou/widgets/bar.dart';
import 'package:foryou/screens/category_products.dart';
import 'package:foryou/screens/cart.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  static final List<Map<String, dynamic>> _categories = [
    {
      'name': 'Women',
      'slug': 'womens-dresses',
      'icon': Icons.woman,
      'colors': [Color(0xFFF9D9D9), Color(0xFFFFF5F5)],
    },
    {
      'name': 'Men',
      'slug': 'mens-shirts',
      'icon': Icons.man,
      'colors': [Color(0xFFBFD9F9), Color(0xFFEAF3FF)],
    },
    {
      'name': 'Kids',
      'slug': 'tops',
      'icon': Icons.child_friendly,
      'colors': [Color(0xFFF3D9F9), Color(0xFFFFF0FB)],
    },
    {
      'name': 'Accessories',
      'slug': 'womens-jewellery',
      'icon': Icons.diamond_outlined,
      'colors': [Color(0xFFD9F9E3), Color(0xFFF0FFF5)],
    },
    {
      'name': 'Beauty & Skincare',
      'slug': 'beauty',
      'icon': Icons.brush,
      'colors': [Color(0xFFF9D9E3), Color(0xFFFFF0F5)],
    },
    {
      'name': 'Shoes & Bags',
      'slug': 'womens-shoes',
      'icon': Icons.shopping_bag,
      'colors': [Color(0xFFF9F3D9), Color(0xFFFFFDF0)],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd9efff),
      appBar: AppBar(
        backgroundColor: const Color(0xffd9efff),
        title: const Text('Categories'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xffd4edff),
                border: Border.all(color: const Color(0xff89b9f8), width: 1),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Fav()),
                  );
                },
                icon: const Icon(Icons.bookmark, color: Color(0xff89b9f8)),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  hint: const Text('Which category you need ?'),
                  prefixIcon: const Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: _categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryProducts(
                            categoryName: category['name'],
                            categorySlug: category['slug'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: category['colors'],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category['icon'],
                            size: 50,
                            color: Colors.black87,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            category['name'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Bar(currentPage: 'categories'),
    );
  }
}
