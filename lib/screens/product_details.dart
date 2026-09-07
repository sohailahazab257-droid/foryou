import 'package:flutter/material.dart';
import 'package:foryou/models/product_model.dart';
import 'package:foryou/services/cart_store.dart';
import 'package:foryou/widgets/orderbutton.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    required this.product,
    super.key,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(product.title),

        backgroundColor: theme.scaffoldBackgroundColor,

        foregroundColor:
        theme.appBarTheme.foregroundColor ??
            theme.textTheme.titleLarge?.color,

        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // ================= IMAGE =================

            Image.network(
              product.thumbnail,
              width: double.infinity,
              height: 240,
              fit: BoxFit.contain,

              errorBuilder: (
                  context,
                  error,
                  stackTrace,
                  ) {
                return Container(
                  width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.dark
                        ? const Color(0xff2a2a2a)
                        : const Color(0xffd9f1ff),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 50,
                    color: theme
                        .textTheme
                        .bodyMedium
                        ?.color,
                  ),
                );
              },
            ),

            const Spacer(flex: 1),

            // ================= CATEGORY =================

            Text(
              'Category: ${product.category}',
              style: theme.textTheme.labelLarge,
            ),

            const SizedBox(height: 20),

            // ================= TITLE =================

            Text(
              product.title,
              style: theme.textTheme.headlineSmall,
            ),

            const SizedBox(height: 8),

            // ================= RATING =================

            _RatingStars(
              rating: product.rating,
            ),

            const SizedBox(height: 8),

            // ================= PRICE =================

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '\$${product.price}',
                style: theme.textTheme.titleLarge,
              ),
            ),

            const SizedBox(height: 15),

            // ================= DESCRIPTION =================

            Text(
              'Description',
              style: theme.textTheme.headlineSmall,
            ),

            const SizedBox(height: 16),

            Text(
              product.description,
              style: theme.textTheme.bodyMedium,
            ),

            const Spacer(flex: 1),

            // ================= ORDER BUTTON =================

            Padding(
              padding: const EdgeInsets.only(
                bottom: 30,
              ),
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

// ================= RATING STARS =================

class _RatingStars extends StatelessWidget {
  const _RatingStars({
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        ...List.generate(
          5,
              (index) {
            final starValue = index + 1;

            IconData icon;

            if (rating >= starValue) {
              icon = Icons.star;
            } else if (rating >= starValue - 0.5) {
              icon = Icons.star_half;
            } else {
              icon = Icons.star_border;
            }

            return Icon(
              icon,
              color: Colors.amber,

              size: 20,
            );
          },
        ),

        const SizedBox(width: 6),

        Text(
          rating.toStringAsFixed(1),
          style: theme.textTheme.labelLarge,
        ),
      ],
    );
  }
}