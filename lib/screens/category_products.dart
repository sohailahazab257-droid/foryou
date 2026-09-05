import 'package:flutter/material.dart';
import 'package:foryou/models/product_model.dart';
import 'package:foryou/screens/favorit.dart';

import 'package:foryou/services/all_porducts.dart';

import 'package:foryou/widgets/product.dart';

class CategoryProducts extends StatefulWidget {
  const CategoryProducts({
    required this.categoryName,
    required this.categorySlug,
    super.key,
  });

  final String categoryName;
  final String categorySlug;

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe5f5ff),
      appBar: AppBar(
        backgroundColor: const Color(0xffe5f5ff),
        elevation: 0,
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Text(
            widget.categoryName,
            style: const TextStyle(fontSize: 16),
          ),
        ),
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
      body: FutureBuilder<List<ProductModel>>(
        future: AllPorducts().get_products_by_category(widget.categorySlug),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Failed to load products'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 18),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(product: product);
            },
          );
        },
      ),
    );
  }
}
