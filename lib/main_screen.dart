import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(user: widget.user),
      const MarketplacePage(),
      const FavoritesPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Menyediakan objek 'user' ke seluruh widget di bawahnya (seperti MarketplacePage)
    // agar bisa diakses menggunakan Provider.of<User>(context).
    return Provider<User>.value(
      value: widget.user,
      child: Scaffold(
        // IndexedStack menjaga state setiap halaman. Artinya, saat berpindah tab,
        // posisi scroll atau input di halaman sebelumnya tidak akan hilang.
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          // 'fixed' memastikan semua label item terlihat, bahkan yang tidak aktif.
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              // Menggunakan ikon dari library FontAwesome
              icon: FaIcon(FontAwesomeIcons.store),
              activeIcon: FaIcon(FontAwesomeIcons.store),
              label: 'Marketplace',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue.shade700,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}