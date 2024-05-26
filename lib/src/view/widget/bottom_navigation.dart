import 'package:flutter/material.dart';
import 'package:green_tech/src/view/screen/home_screen.dart';
import 'package:green_tech/src/view/screen/setting_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        // indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        const HomeScreen(),

        /// Setting page
        const SettingScreen(),
      ][currentPageIndex],
    );
  }
}
