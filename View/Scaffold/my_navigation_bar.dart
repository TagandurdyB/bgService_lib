import 'package:flutter/material.dart';
import '/View/Scaffold/provider_navigation_bar.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: _selectIndex,
        onTap: (index) {
          setState(() {
            _selectIndex = index;
          });
          ProcessNavigationBar(context).screenIndex(index);
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey[400],
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(
                Icons.home_rounded,
                color: Colors.white,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              activeIcon: Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              label: "Location"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_suggest_sharp),
              activeIcon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: "Setting"),
        ]);
  }
}
