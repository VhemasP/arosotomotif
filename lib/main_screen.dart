import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'admin_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'marketplace_screen.dart';
import 'profile_screen.dart';
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
      // Navigasi KHUSUS untuk Admin (TANPA PROFIL)
      _pages = [
        HomePage(user: widget.user),
        const MarketplaceScreen(),
        const FavoriteScreen(),
        const AdminScreen(),
      ];
      _navItems = [
        const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        const BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.store), label: 'Marketplace'),
        const BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
        const BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings_outlined), label: 'Admin'),
      ];
    } else {
      // Navigasi untuk User Biasa (DENGAN PROFIL)
      _pages = [
        HomePage(user: widget.user),
        const MarketplaceScreen(),
        const FavoriteScreen(),
        const ProfileScreen(),
      ];
      _navItems = [
        const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        const BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.store), label: 'Marketplace'),
        const BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
        const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
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
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}