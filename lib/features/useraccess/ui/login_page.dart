import '../bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthBloc>(
        builder: (BuildContext context, AuthBloc bloc, Widget child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  bloc.isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          child: Text('Login Anonymously'),
                          onPressed: () {
                            Provider.of<AuthBloc>(context, listen: false)
                                .login(context);
                          },
                        ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
