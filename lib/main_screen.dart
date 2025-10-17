import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'admin_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'marketplace_screen.dart';
import 'model/user.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({super.key, required this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _pages = [];
  List<BottomNavigationBarItem> _navItems = [];

  @override
  void initState() {
    super.initState();
    _buildNavigation(widget.user.isAdmin);
  }

  void _buildNavigation(bool isAdmin) {
    if (isAdmin) {
      _pages = [
        HomePage(user: widget.user),
        const MarketplaceScreen(),
        const FavoritesPage(),
        const AdminScreen(),
      ];
      _navItems = [
        const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
        const BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.store), label: 'Marketplace'),
        const BottomNavigationBarItem(icon: Icon(Icons.favorite_border), activeIcon: Icon(Icons.favorite), label: 'Favorites'),
        const BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings_outlined), activeIcon: Icon(Icons.admin_panel_settings), label: 'Admin'),
      ];
    } else {
      _pages = [
        HomePage(user: widget.user),
        const MarketplaceScreen(),
        const FavoritesPage(),
      ];
      _navItems = [
        const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
        const BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.store), label: 'Marketplace'),
        const BottomNavigationBarItem(icon: Icon(Icons.favorite_border), activeIcon: Icon(Icons.favorite), label: 'Favorites'),
      ];
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider<User>.value(
      value: widget.user,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: _navItems,
          currentIndex: _selectedIndex,
          selectedItemColor: widget.user.isAdmin ? Colors.indigo.shade700 : Colors.blue.shade700,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}