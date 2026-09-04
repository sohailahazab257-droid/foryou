import 'package:flutter/material.dart';
import 'package:foryou/home/bar.dart';
class Cate extends StatelessWidget {
  const Cate({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          bottomNavigationBar: const Bar(
            currentPage: 'categories',)),
    );
  }
}
