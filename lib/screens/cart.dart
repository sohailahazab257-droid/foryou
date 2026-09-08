import 'package:flutter/material.dart';

import 'package:foryou/cubit/app_colors.dart';
import 'package:foryou/models/product_model.dart';
import 'package:foryou/screens/product_details.dart';
import 'package:foryou/services/cart_store.dart';
import 'package:foryou/widgets/bar.dart';
import 'favorit.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});


  @override
  State<Cart> createState() => _CartState();
}
class _CartState extends State<Cart> {
  final Map<int, int> _quantities = {};

  int _quantityFor(ProductModel product) {
    return _quantities.putIfAbsent(product.id, () => 1);
  }

  void _changeQuantity(ProductModel product, int change) {
    setState(() {
      final quantity = (_quantities[product.id] ?? 1) + change;
      _quantities[product.id] = quantity.clamp(1, 99);
    });
  }

  void _removeProduct(ProductModel product) {
    CartStore.instance.removeFromCart(product);
    _quantities.remove(product.id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: SafeArea(
        bottom: false,
        child: ListenableBuilder(
          listenable: CartStore.instance,
          builder: (context, child) {
            final items = CartStore.instance.items;

            final total = items.fold<double>(
              0,
                  (sum, product) =>
              sum + product.price * _quantityFor(product),
            );

            return Column(
              children: [
                _CartHeader(isDark: isDark),

                Expanded(
                  child: items.isEmpty
                      ? Center(
                    child: Text(
                      'Your cart is empty',
                      style: TextStyle(
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                  )
                      : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      18,
                      4,
                      18,
                      14,
                    ),
                    itemCount: items.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.78,
                    ),
                    itemBuilder: (context, index) {
                      final product = items[index];

                      return _CartProductCard(
                        product: product,
                        quantity: _quantityFor(product),
                        isDark: isDark,
                        onIncrement: () =>
                            _changeQuantity(product, 1),
                        onDecrement: () =>
                            _changeQuantity(product, -1),
                        onRemove: () =>
                            _removeProduct(product),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetails(
                                    product: product,
                                  ),
                            ),
                          );
                        },
                      );
                    },
                  ),

                ),if (items.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      18,
                      0,
                      18,
                      14,
                    ),
                    child: _CartSummary(
                      total: total,
                      isDark: isDark,
                    ),
                  ),
              ],
            );
          },
        ),
      ),

      bottomNavigationBar: const Bar(
        currentPage: 'cart',
      ),
    );
  }
}

class _CartHeader extends StatelessWidget {
  const _CartHeader({
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cart',
                style: TextStyle(
                  color: theme.textTheme.titleLarge?.color,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,

                    border: Border.all(
                      color: const Color(0xff89b9f8),
                      width: 1,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Fav(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.bookmark,
                      color: Color(0xff89b9f8),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          TextField(
            decoration: InputDecoration(
              hintText: 'Search what you order',

              hintStyle: TextStyle(
                color: isDark
                    ? Colors.grey.shade400
                    : const Color(0xff78848a),
              ),

              prefixIcon: Icon(
                Icons.search,
                color: isDark
                    ? Colors.grey.shade300
                    : const Color(0xff52636c),
              ),
              filled: true,
              fillColor: isDark
                  ? const Color(0xff2a2a2a)
                  : Colors.white,

              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _CartProductCard extends StatelessWidget {
  const _CartProductCard({
    required this.product,
    required this.quantity,
    required this.isDark,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
    required this.onTap,
  });

  final ProductModel product;
  final int quantity;
  final bool isDark;

  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;
  final VoidCallback onTap;@override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(7),

        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xff252525)
              : Colors.white.withValues(alpha: 0.62),

          borderRadius: BorderRadius.circular(16),

          border: Border.all(
            color: isDark
                ? const Color(0xff3a3a3a)
                : Colors.white.withValues(alpha: 0.9),
          ),

          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : const Color(0x16000000),
              blurRadius: 5,
              offset: const Offset(1, 2),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.thumbnail,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (
                      context,
                      error,
                      stackTrace,
                      ) {
                    return Container(
                      color: isDark
                          ? const Color(0xff333333)
                          : const Color(0xffd9f1ff),
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.black54,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 5),

            Row(
              children: [

                Expanded(
                  child: Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ),

                const SizedBox(width: 4),

                _PriceTag(
                  price: product.price,
                  isDark: isDark,
                ),
              ],
            ),

            const SizedBox(height: 5),

            Row(
              children: [
                _SmallControl(
                  icon: Icons.add,
                  onTap: onIncrement,
                  isDark: isDark,
                ),

                SizedBox(
                  width: 24,
                  child: Center(
                    child: Text(
                      '$quantity',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                ),

                _SmallControl(
                  icon: Icons.remove,
                  onTap: onDecrement,
                  isDark: isDark,
                ),

                const Spacer(),

                IconButton(
                  onPressed: onRemove,
                  tooltip: 'Remove from cart',
                  padding: EdgeInsets.zero,constraints: const BoxConstraints(
                  minWidth: 28,
                  minHeight: 28,
                ),
                  icon: Icon(
                    Icons.delete_outline,
                    size: 19,
                    color: isDark
                        ? Colors.grey.shade400
                        : const Color(0xff84929a),
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

// ================= PRICE TAG =================

class _PriceTag extends StatelessWidget {
  const _PriceTag({
    required this.price,
    required this.isDark,
  });

  final double price;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xff35566b)
            : const Color(0xffc9ecff),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '\$${price.toStringAsFixed(0)}',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

// ================= SMALL CONTROL =================

class _SmallControl extends StatelessWidget {
  const _SmallControl({
    required this.icon,
    required this.onTap,
    required this.isDark,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark
          ? const Color(0xff35566b)
          : const Color(0xffd2efff),

      borderRadius: BorderRadius.circular(5),

      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5),
        child: SizedBox(
          width: 20,
          height: 20,
          child: Icon(
            icon,
            size: 14,
            color: isDark
                ? Colors.white
                : AppColors.dark,
          ),
        ),
      ),
    );
  }
}

// ================= CART SUMMARY =================

class _CartSummary extends StatelessWidget {
  const _CartSummary({
    required this.total,
    required this.isDark,
  });

  final double total;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 5,
          ),

          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xff35566b)
                : const Color(0xffd0efff),
            borderRadius: BorderRadius.circular(12),
          ),

          child: Text(
            'Total Price: \$${total.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isDark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),

        const SizedBox(width: 8),

        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Successful order'),
              ),
            );
          },

          style: ElevatedButton.styleFrom(
            backgroundColor: isDark
                ? const Color(0xff35566b)
                : const Color(0xffc9ecff),

            foregroundColor: isDark
                ? Colors.white
                : AppColors.dark,

            elevation: 0,

            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 7,
            ),

            minimumSize: Size.zero,

            tapTargetSize:
            MaterialTapTargetSize.shrinkWrap,shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          ),

          child: const Text(
            'Order Now',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }}