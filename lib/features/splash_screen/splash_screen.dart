import '../home/home_page.dart';
import '../useraccess/ui/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    _isUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Text(
          'Expense Manager',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    ));
  }

  void _isUserLoggedIn() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      print('Error = $e');
    }

    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    await Future.delayed(Duration(seconds: 1));
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    }
  }
}
