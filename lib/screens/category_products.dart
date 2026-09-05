import 'package:flutter/material.dart';
import 'package:foryou/models/product_model.dart';
import 'package:foryou/screens/product_details.dart';
import 'package:foryou/screens/cart.dart';
import 'package:foryou/services/all_porducts.dart';
import 'package:foryou/widgets/item_card.dart';

class CategoryProducts extends StatelessWidget {
  const CategoryProducts({
    required this.categoryName,
    required this.categorySlug,
    super.key,
  });

  final String categoryName;
  final String categorySlug;

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
          child: Text(categoryName, style: const TextStyle(fontSize: 16)),
        ),
        actions: [
          IconButton(
            tooltip: 'Cart',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Cart()),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: AllPorducts().get_products_by_category(categorySlug),
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
              return ItemCard(
                porduct: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetails(product: product),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
