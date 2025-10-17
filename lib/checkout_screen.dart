import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/listing.dart';
import 'providers/marketplace_provider.dart';

class CheckoutPage extends StatelessWidget {
  final Listing listing;
  const CheckoutPage({super.key, required this.listing});

  void _confirmPurchase(BuildContext context) {
    Provider.of<MarketplaceProvider>(context, listen: false).purchaseListing(listing);


    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('Pembelian Berhasil!'),
        content: Text('Anda telah berhasil membeli ${listing.vehicle.nama}. Penjual (${listing.sellerEmail}) akan segera menghubungi Anda.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Kembali ke halaman marketplace (menutup checkout dan detail)
              Navigator.of(ctx).pop(); // Tutup dialog
              Navigator.of(context).pop(); // Tutup checkout
              Navigator.of(context).pop(); // Tutup detail
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Ringkasan Pembelian", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Image.network(listing.vehicle.imageUrl, height: 150),
                    const SizedBox(height: 12),
                    Text(listing.vehicle.nama, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: const Icon(Icons.sell, color: Colors.grey),
                      title: const Text('Harga'),
                      trailing: Text(
                        listing.vehicle.harga,
                        style: TextStyle(fontSize: 18, color: Colors.blue.shade800, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.grey),
                      title: const Text('Penjual'),
                      trailing: Text(listing.sellerEmail),
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_pin, color: Colors.grey),
                      title: const Text('Lokasi'),
                      trailing: Text(listing.location),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Di aplikasi nyata, di sini akan ada form alamat, metode pembayaran, dll.
            // Untuk simulasi, kita langsung ke tombol konfirmasi.
            const Text("Detail Pengiriman & Pembayaran", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Fitur ini akan tersedia di versi selanjutnya. Untuk sekarang, silakan konfirmasi pembelian Anda.", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _confirmPurchase(context),
                icon: const Icon(Icons.shopping_cart_checkout),
                label: const Text('Konfirmasi Pembelian'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}