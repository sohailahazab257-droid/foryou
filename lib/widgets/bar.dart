import 'package:flutter/material.dart';
import 'package:foryou/screens/home.dart';
import 'package:foryou/screens/profile.dart';
import 'package:foryou/screens/cart.dart';
import 'package:foryou/screens/category.dart';

class Bar extends StatelessWidget {
  final String currentPage;

  const Bar({super.key, required this.currentPage});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(25),
        ),
        color: Colors.white,
      ),

      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
              icon: const Icon(Icons.person),
              color: currentPage == 'profile'
                  ? const Color(0xff89b9f8)
                  : Colors.black,
              iconSize: 40,
            ),

            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
              icon: const Icon(Icons.home),
              color: currentPage == 'home'
                  ? const Color(0xff89b9f8)
                  : Colors.black,
              iconSize: 40,
            ),

            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Category()),
                );
              },
              icon: const Icon(Icons.category),
              color: currentPage == 'categories'
                  ? const Color(0xff89b9f8)
                  : Colors.black,
              iconSize: 40,
            ),

            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Cart()),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              color: currentPage == 'cart'
                  ? const Color(0xff89b9f8)
                  : Colors.black,
              iconSize: 40,
            ),
          ],
        ),
      ),
    );
  }
}
