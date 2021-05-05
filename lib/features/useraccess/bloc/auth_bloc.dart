import '../../../core/base_bloc.dart';
import '../../../core/ui_util.dart';
import '../../home/home_page.dart';
import '../../splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authentication_service.dart';

class AuthBloc extends BaseBloc {
  AuthService _authService;
  AuthBloc() {
    _authService = AuthService();
  }

  void login(context) async {
    print('login');
    setLoading(true);
    final result = await _authService.signInAnonymously();
    setLoading(false);

    if (result == null) {
      //UnKnown error
      UIUtils.displayDialog(
        context: context,
        title: 'Error',
        message: 'Something went wrong pleas try again later.',
      );
    } else if (result is UserCredential) {
      //Login successful
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => HomePage()),
        (route) => false,
      );
    } else {
      // Error message returned as String
      UIUtils.displayDialog(
        context: context,
        title: 'Error',
        message: '$result',
      );
    }
  }

  void logout(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => SplashScreenPage()),
      (route) => false,
    );
  }
}
