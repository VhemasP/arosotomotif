import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_screen.dart';
import 'detail_screen.dart';
import 'model/user.dart';
import 'model/item_list.dart';
import 'model/kendaraan.dart';
import 'providers/favorite_provider.dart';

class HomePage extends StatelessWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<Kendaraan> vehicles = vehicleList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Welcome Section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 24.0),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Selamat datang,', style: TextStyle(fontSize: 22.0, color: Colors.white)),
                      const SizedBox(height: 4.0),
                      Text(
                        user.email,
                        style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                  // Tombol Logout
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                            (Route<dynamic> route) => false,
                      );
                    },
                    tooltip: 'Logout',
                  ),
                ],
              ),
            ],
          ),
        ),

        // List Title
        const Padding(
          padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 8.0),
          child: Text(
            'Katalog Kendaraan',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black54),
          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
                elevation: 5.0,
                shadowColor: Colors.black.withOpacity(0.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(kendaraan: vehicle),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        // Gambar
                        SizedBox(
                          width: 120,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              vehicle.imageUrl,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Detail Text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(vehicle.nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              const SizedBox(height: 6),
                              Text(vehicle.getDeskripsiSingkat(), style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                              const SizedBox(height: 8),
                              Text(vehicle.harga, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blue.shade800)),
                            ],
                          ),
                        ),
                        Consumer<FavoritesProvider>(
                          builder: (context, provider, child) => IconButton(
                            icon: Icon(
                              provider.isFavorite(vehicle.nama) ? Icons.favorite : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              provider.toggleFavorite(vehicle.nama);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}