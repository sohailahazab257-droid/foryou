import 'package:flutter/material.dart';
import 'package:foryou/logic/product_logic.dart';

import 'package:foryou/services/cart_store.dart';
import 'package:foryou/models/product_model.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({required this.product, required this.onTap, super.key});

  final ProductModel product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isFavorite = ProductLogic.isFavorite(product);
    return Card(
      margin: const EdgeInsets.all(6),
      elevation: 0,
      color: Colors.white.withValues(alpha: 0.78),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xffc9d9df)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 7, 7, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      tooltip: 'Favorite',
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {
                        ProductLogic.toggleFavorite(product);
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.pinkAccent,
                        size: 27,
                      ),
                    ),
                  ),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      product.thumbnail,
                      height: 112,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 112,
                          child: Center(child: Icon(Icons.image_not_supported)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${product.stock} Stocks Left',
                    style: const TextStyle(
                      color: Color(0xfff13d68),
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      Text(
                        ' ${product.rating.toStringAsFixed(1)}',
                        style: const TextStyle(fontSize: 10),
                      ),
                      const Spacer(),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color(0xffd8efff),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          child: Text(
                            '\$${product.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                ],
              ),
            ),
            Positioned(
              left: -2,
              top: -2,
              child: IconButton(
                tooltip: 'Add to cart',
                onPressed: () {
                  CartStore.instance.addToCart(product);
                },
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xffffb5c8),
                  foregroundColor: Colors.white,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(4),
                ),
                icon: const Icon(Icons.add, size: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
