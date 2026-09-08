import 'package:flutter/material.dart';

class Buildofferbanner extends StatelessWidget {
  Buildofferbanner({ this.image});
  String? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset(image!, fit: BoxFit.cover)),

          const Positioned(
            left: 23,
            top: 30,
            child: Text(
              'GET 30% OFF',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          const Positioned(
            left: 25,
            top: 72,
            child: Text(
              'Limited Offer',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),

          Positioned(
            left: 25,
            bottom: 25,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'SHOP NOW',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
