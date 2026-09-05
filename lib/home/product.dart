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
  List<dynamic> products = [];
  String selectedCategory = 'All';
  bool isLoading = true;
  final Map<String, String> categories = {
    'Women': 'womens-dresses',
    'Men': 'mens-shirts',
    'Kids': 'tops',
    'Jewellery': 'womens-jewellery',
    'Women Watches': 'womens-watches',
    'Men Watches': 'mens-watches',
    'Sunglasses': 'sunglasses',
    'Beauty': 'beauty',
    'Skin Care': 'skin-care',
    'Fragrances': 'fragrances',
    'Women Shoes': 'womens-shoes',
    'Women Bags': 'womens-bags',
    'Men Shoes': 'mens-shoes',
  };

  Future<void> getData(String category) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (category == 'All') {
        List<dynamic> allProducts = [];

        for (final categoryValue in categories.values) {
          final response = await http.get(
            Uri.parse(
              'https://dummyjson.com/products/category/$categoryValue',
            ),
          );

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            allProducts.addAll(data['products']);
          }
        }

        setState(() {
          products = allProducts;
          isLoading = false;
        });
      } else {
        final response = await http.get(
          Uri.parse(
            'https://dummyjson.com/products/category/$category',
          ),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          setState(() {
            products = data['products'];
            isLoading = false;
          });
        } else {
          setState(() {
            products = [];
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print(e);

      setState(() {
        products = [];
        isLoading = false;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getData('All');
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
        getData(categoryValue);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 2, left: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xffC9ECFF)
              : Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.blue.shade100,
          ),
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
              ...categories.keys.map((category) {
                return categoryButton(
                  name: category,
                  categoryValue: categories[category]!,
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
        if (isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: CircularProgressIndicator(),
            ),
          )
        else if (products.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'No products found',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ) else GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              childAspectRatio: 0.70,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
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
      margin: const EdgeInsets.only(
        right: 12,
        left: 12,
      ),
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
                height: 140,
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
                  child: Text('\$${product['price']}',
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
                Text('${product['rating']}',
                  style: const TextStyle(
                    fontSize: 13,
                  ),
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
                          builder: (context) =>
                          const ProductDetails(),
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
                      isInCart
                          ? Icons.check
                          : Icons.add,
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