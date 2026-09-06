import 'package:flutter/material.dart';
import 'package:foryou/screens/home.dart';
import 'screens/register_page.dart';
import 'screens/login_page.dart';
import 'screens/create_account_page.dart';
import 'screens/splash_page.dart';
import 'screens/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashPage());
  }
}
