import 'package:flutter/material.dart';
import 'package:foryou/home/bar.dart';
import 'package:foryou/services/cart_store.dart';
import 'package:foryou/widgets/orderbutton.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: ListenableBuilder(
        listenable: CartStore.instance,
        builder: (context, child) {
          final items = CartStore.instance.items;
          if (items.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          final total = items.fold<double>(
            0,
            (sum, product) => sum + product.price,
          );
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final product = items[index];
                    return ListTile(
                      tileColor: Theme.of(context).colorScheme.surface,
                      leading: Image.network(
                        product.thumbnail,
                        width: 56,
                        height: 56,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image_not_supported);
                        },
                      ),
                      title: Text(product.title),
                      subtitle: Text('\$${product.price}'),
                      trailing: IconButton(
                        tooltip: 'Remove from cart',
                        onPressed: () {
                          CartStore.instance.removeFromCart(product);
                        },
                        icon: const Icon(Icons.delete_outline),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 62, 162, 244),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(' Total : ', style: TextStyle(fontSize: 25)),
                      Text(
                        '\$${total.toStringAsFixed(2)} ',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Orderbutton(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Successful order')),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const Bar(currentPage: 'cart'),
    );
  }
}
