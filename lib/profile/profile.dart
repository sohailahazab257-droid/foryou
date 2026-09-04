import 'package:flutter/material.dart';
import 'package:foryou/home/bar.dart';
class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          bottomNavigationBar: const Bar(
            currentPage: 'profile',)),
    );
  }
}
