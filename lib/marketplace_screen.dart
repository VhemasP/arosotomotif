import 'package:aros_otomotif/checkout_screen.dart';
import 'package:aros_otomotif/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'checkout_screen.dart';
import 'detail_screen.dart';
import 'providers/marketplace_provider.dart';
import 'model/user.dart';

class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    final listings = marketplaceProvider.listings;
    final currentUser = Provider.of<User>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: listings.isEmpty
          ? Center( /* ... Tampilan marketplace kosong ... */ )
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
                    builder: (_) => Provider<User>.value(
                      value: currentUser,
                      child: DetailScreen(
                        kendaraan: listing.vehicle,
                        listing: listing,
                      ),
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(listing.vehicle.imageUrl), // Pastikan ini Image.asset
                    const SizedBox(height: 12),
                    Text(listing.vehicle.nama, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(listing.vehicle.harga, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue.shade800)),
                    const Divider(height: 24),
                    Text(listing.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey.shade700)),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Provider<User>.value(
                                value: currentUser,
                                child: CheckoutScreen(listing: listing),
                              ),
                            ),
                          );
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