// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:recipe_app/pages/Home/Body.dart';

enum TabItem {
  home,
  recipes,
  search,
  settings,
}

class HomePage extends StatefulWidget {
  HomePage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem currentTab = TabItem.home;

  void _selectTab(TabItem tabItem) => setState(() {
        currentTab = tabItem;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text(widget.title),
      ),
      // Consider a floating action button somewhere
      body: HomeBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green[900],
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank), label: 'Recipes'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        // currentIndex: currentTab,
      ),
    );
  }
}
