import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'detail_screen.dart';
import 'model/item_list.dart';
import 'providers/favorite_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    final favoriteVehicles = vehicleList
        .where((vehicle) => favoritesProvider.isFavorite(vehicle.nama))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: favoriteVehicles.isEmpty
          ? const Center(
        child: Text(
          'Anda belum memiliki kendaraan favorit.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: favoriteVehicles.length,
        itemBuilder: (context, index) {
          final vehicle = favoriteVehicles[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              leading: Image.asset(vehicle.imageUrl, width: 80, fit: BoxFit.cover),
              title: Text(vehicle.nama),
              subtitle: Text(vehicle.harga),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(kendaraan: vehicle),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}