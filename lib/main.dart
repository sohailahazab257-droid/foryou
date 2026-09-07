import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foryou/screens/home.dart';
import 'cubit/app_theme.dart';
import 'cubit/app_theme_cubit.dart';
import 'screens/register_page.dart';
import 'screens/login_page.dart';
import 'screens/create_account_page.dart';
import 'screens/splash_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => AppThemeCubit(),
      child: const MyApp(),
    ),

  );
}class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.watch<AppThemeCubit>().state,
      home: const SplashPage(),
    );
  }
}