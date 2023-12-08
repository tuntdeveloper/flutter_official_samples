import 'package:flutter/material.dart';
import 'package:flutter_nexlesoft_getx/presentation/auth/sign_up_screen.dart';
import 'package:flutter_nexlesoft_getx/presentation/home/home_screen.dart';

enum AppRoute {
  home,
  signUp;

  const AppRoute();

  String get getPath {
    switch (this) {
      case AppRoute.home:
        return '/home';
      case AppRoute.signUp:
        return '/sign_up';
    }
  }

  Widget Function() get getPage {
    switch (this) {
      case AppRoute.home:
        return () => HomeScreen();
      case AppRoute.signUp:
        return () => SignUpScreen();
    }
  }
}


