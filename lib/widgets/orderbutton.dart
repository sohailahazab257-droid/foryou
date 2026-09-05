import 'package:flutter/material.dart';


class Orderbutton extends StatelessWidget {
  Orderbutton({super.key, required this.onTap});

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
      child: Center(
        child: Text('Order now ', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
