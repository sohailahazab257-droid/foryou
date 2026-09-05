import 'package:flutter/material.dart';
import 'package:foryou/models/product_model.dart';
import 'package:foryou/services/cart_store.dart';
import 'package:foryou/widgets/orderbutton.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({required this.product, super.key});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe5f5ff),
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: const Color(0xffe5f5ff),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.thumbnail,
              width: double.infinity,
              height: 240,
              fit: BoxFit.contain,
            ),
            Spacer(flex: 1),
            Text(
              'Category: ${product.category}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 20),
            Text(
              product.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            _RatingStars(rating: product.rating),
            const SizedBox(height: 8),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: Text(
                '\$${product.price}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            Text(
              'Description',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(product.description),
            Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Orderbutton(
                onTap: () {
                  CartStore.instance.addToCart(product);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingStars extends StatelessWidget {
  const _RatingStars({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          final starValue = index + 1;
          IconData icon;
          if (rating >= starValue) {
            icon = Icons.star;
          } else if (rating >= starValue - 0.5) {
            icon = Icons.star_half;
          } else {
            icon = Icons.star_border;
          }
          return Icon(icon, color: Colors.amber, size: 20);
        }),
        const SizedBox(width: 6),
        Text(
          rating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
