import 'package:flutter/material.dart';
import '../screens/homescreen.dart';
import '../screens/cart.dart';
import '../screens/reorder.dart';
import '../screens/settings.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key, required int currentIndex, required Null Function(dynamic index) onTap}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

 
  static final List<Widget> _screens = <Widget>[
    const HomeScreenPage(),
    const CartScreen(itemQuantities: {}, items: [],),
    const ReorderScreen(),
    const SettingsScreen(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _screens[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(IconData(0xe532, fontFamily: 'MaterialIcons')),
          label: 'Reorder',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(color: Colors.green),
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      onTap: _onItemTapped,
    );
  }
}