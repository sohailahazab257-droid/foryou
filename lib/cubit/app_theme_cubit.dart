import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemeCubit extends Cubit<ThemeMode> {
  AppThemeCubit() : super(ThemeMode.light);

  void toggleTheme() {
    emit(
      state == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }
}