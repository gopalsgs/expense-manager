import '../useraccess/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'),),
      body: Column(
        children: [
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout),
            onTap: () {
              Provider.of<AuthBloc>(context, listen: false).logout(context);
            },
          )
        ],
      ),
    );
  }
}
