import 'package:flutter/material.dart';

import '../pages/category_page.dart';
import '../pages/group_page.dart';
import '../pages/news_page.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedPageIndex = 0;
  List<Widget> pages = [
    NewsPage(),
    CategoryPage(),
    GroupPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: pages[selectedPageIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              selectedPageIndex = index;
            });
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
              selectedIcon: Icon(Icons.newspaper),
              icon: Icon(Icons.newspaper_outlined),
              label: 'News',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.category),
              icon: Icon(Icons.category_outlined),
              label: 'Category',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.group),
              icon: Icon(Icons.group_outlined),
              label: 'Group',
            ),
          ],
        ),
    );
  }
}