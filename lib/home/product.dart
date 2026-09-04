import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:foryou/logic/product_logic.dart';
import 'package:foryou/details/details.dart';

class CategoriesProducts extends StatefulWidget {
  const CategoriesProducts({super.key});
  @override
  State<CategoriesProducts> createState() => _CategoriesProductsState();
}

class _CategoriesProductsState extends State<CategoriesProducts> {
  final String productsUrl = 'https://dummyjson.com/products';
  List<dynamic> products = [];
  String selectedCategory = 'All';
  bool isLoading = true;

  final Map<String, List<String>> categoryGroups = {
    'Women': ['womens-dresses'],
    'Men': ['mens-shirts'],
    'Kids': ['tops'],
    'Accessories': [
      'womens-jewellery',
      'womens-watches',
      'mens-watches',
      'sunglasses'
    ],
    'Makeup & Skin Care': [
      'beauty',
      'skin-care',
      'fragrances'
    ],
    'Shoes & Bags': [
      'womens-shoes',
      'womens-bags',
      'mens-shoes'
    ],
  };

  Future<void> getData() async {
    try {
      final productsResponse = await http.get(Uri.parse(productsUrl));
      if (productsResponse.statusCode == 200) {
        final productsData = jsonDecode(productsResponse.body);
        setState(() {
          products = productsData['products'];
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getData();
  }

  List<dynamic> get filteredProducts {
    if (selectedCategory == 'All') {
      return products.where((product) {
        return categoryGroups.values
            .expand((categories) => categories)
            .contains(product['category']);
      }).toList();
    }
    final selectedCategories = categoryGroups[selectedCategory] ?? [];

    return products.where((product) {
      return selectedCategories.contains(product['category']);
    }).toList();
  }

  Widget categoryButton({
    required String name,
    required String categoryValue,
  }) {
    final bool isSelected = selectedCategory == categoryValue;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = categoryValue;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 2, left: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xffC9ECFF)
              : Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade700,
            fontWeight:
            isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              categoryButton(
                name: 'All',
                categoryValue: 'All',
              ),
              ...categoryGroups.keys.map((category) {
                return categoryButton(
                  name: category,
                  categoryValue: category,
                );
              }).toList(),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            const SizedBox(width: 8),
            const Text(
              'Featured Products',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredProducts.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            childAspectRatio: 0.70,
          ),
          itemBuilder: (context, index) {
            final product = filteredProducts[index];

            return ProductCard(
              product: product,
            );
          },
        ),
      ],
    );
  }
}

class ProductCard extends StatefulWidget {
  final dynamic product;
  const ProductCard({
    super.key,
    required this.product,
  });
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final isFavorite = ProductLogic.isFavorite(product);
    final isInCart = ProductLogic.isInCart(product);
    return Container(
      margin: const EdgeInsets.only(right: 12, left: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                product['thumbnail'],
                width: double.infinity,
                height: 145,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 145,
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${product['stock']} Stocks Left',
                    style: const TextStyle(
                      color: Colors.pink,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffC9ECFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '\$${product['price']}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 18,
                ),
                const SizedBox(width: 3),
                Text(
                  '${product['rating']}',
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductDetails(),
                        ),
                      );
                    },
                    child: Text(
                      product['title'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      ProductLogic.addToCart(product);
                    });
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xffC9ECFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      isInCart ? Icons.check : Icons.add,
                      size: 21,
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      ProductLogic.toggleFavorite(product);
                    });
                  },
                  child: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.pinkAccent,
                    size: 27,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}