import '../settings/settings_page.dart';
import 'package:flutter/material.dart';
import '../transactions/ui/transactions_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int i = 0;

  void changeTab(int index) {
    setState(() {
      i = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = <Widget>[TransactionPage(), SettingsPage()];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          children: tabs,
          index: i,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: i,
        showSelectedLabels: true,
        unselectedItemColor: Color(0xff707070),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.developer_board),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ],
        onTap: changeTab,
      ),
    );
  }
}

