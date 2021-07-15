import 'package:flutter/material.dart';
import 'package:flutter_pokemon/home_screen.dart';
import 'package:flutter_pokemon/bookmarks_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon App',
      home: DefaultTabController(
        length: 2, 
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                ),
                Tab(
                  icon: Icon(Icons.bookmark_border),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              HomeScreen(),
              BookmarksScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
