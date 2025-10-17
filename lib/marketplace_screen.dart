// lib/marketplace_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'checkout_screen.dart';
import 'detail_screen.dart';
import 'providers/marketplace_provider.dart';
import 'sell_vehicle_page.dart';
import 'model/user.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    final listings = marketplaceProvider.listings;
    final currentUser = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Jual Kendaraan',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SellVehiclePage(userEmail: currentUser.email),
                ),
              );
            },
          )
        ],
      ),
      body: listings.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.storefront, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            const Text(
              'Marketplace masih kosong.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: listings.length,
        itemBuilder: (context, index) {
          final listing = listings[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      kendaraan: listing.vehicle,
                      listing: listing,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(listing.vehicle.imageUrl),
                    const SizedBox(height: 12),
                    Text(
                      listing.vehicle.nama,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      listing.vehicle.harga,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    const Divider(height: 24),
                    Text(
                      listing.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.location_pin, size: 16, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(listing.location, style: TextStyle(color: Colors.grey.shade600)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => CheckoutPage(listing: listing),
                          ));
                        },
                        child: const Text('Beli Sekarang'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}