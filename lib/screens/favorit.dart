import 'package:flutter/material.dart';
import 'package:foryou/logic/product_logic.dart';
import 'package:foryou/models/product_model.dart';

class Fav extends StatefulWidget {
  const Fav({super.key});

  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {
  @override
  Widget build(BuildContext context) {
    final favorites = ProductLogic.favoriteProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xffC9ECFF),
      ),

      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'No Favorite Products Yet',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favorites.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: 0.70,
              ),
              itemBuilder: (context, index) {
                final product = favorites[index];
                final thumbnail = product is ProductModel
                    ? product.thumbnail
                    : product['thumbnail'] as String;
                final title = product is ProductModel
                    ? product.title
                    : product['title'] as String;
                final price = product is ProductModel
                    ? product.price
                    : product['price'];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // صورة المنتج
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          thumbnail,
                          width: double.infinity,
                          height: 145,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // اسم المنتج
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      // السعر والقلب
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                              '\$$price',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                ProductLogic.toggleFavorite(product);
                              });
                            },
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.pinkAccent,
                              size: 27,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
