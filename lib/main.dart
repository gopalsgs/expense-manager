import 'features/transactions/bloc/transaction_bloc.dart';

import 'features/categories/bloc/categories_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'features/splash_screen/splash_screen.dart';
import 'features/useraccess/bloc/auth_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthBloc(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoriesBloc(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Expense Manager',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.indigoAccent,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.indigo,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          buttonColor: Colors.indigo,
          buttonTheme: ButtonThemeData(),
          textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 20, color: Colors.white),
          ),
          fontFamily: "Segoe UI",
        ),
        home: SplashScreenPage(),
      ),
    );
  }
}
