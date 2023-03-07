import 'package:flutter/material.dart';

class DBottomNavBar extends StatefulWidget {
  const DBottomNavBar({super.key});

  @override
  _DBottomNavBarState createState() =>
      _DBottomNavBarState();
}

class _DBottomNavBarState extends State<DBottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    //HomeScreen(),
    //ScannerScreen(),
    //CartScreen(),
    //ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
