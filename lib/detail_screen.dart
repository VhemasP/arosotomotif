import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'checkout_screen.dart';
import 'providers/favorite_provider.dart';
import 'model/kendaraan.dart';
import 'model/mobil.dart';
import 'model/motor.dart';
import 'model/listing.dart';

class DetailScreen extends StatefulWidget {
  final Kendaraan kendaraan;
  final Listing? listing;

  const DetailScreen({
    super.key,
    required this.kendaraan,
    this.listing,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double _userRating = 3.5;

  @override
  Widget build(BuildContext context) {
    final bool isMarketplaceItem = widget.listing != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kendaraan.nama),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          Consumer<FavoritesProvider>(
            builder: (context, provider, child) => IconButton(
              icon: Icon(
                provider.isFavorite(widget.kendaraan.nama)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.white,
              ),
              tooltip: 'Add to Favorites',
              onPressed: () {
                provider.toggleFavorite(widget.kendaraan.nama);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 250,
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  widget.kendaraan.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.kendaraan.nama,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.kendaraan.harga,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
            ),

            _buildRatingSection(),

            if (isMarketplaceItem)
              _buildSellerInfoSection(widget.listing!),

            const Divider(height: 24, thickness: 1, indent: 16, endIndent: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Spesifikasi",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  if (widget.kendaraan is Mobil) ...[
                    _buildDetailRow("Tipe", (widget.kendaraan as Mobil).tipe),
                    _buildDetailRow("Mesin", (widget.kendaraan as Mobil).spekMesin),
                    _buildDetailRow("Kapasitas", (widget.kendaraan as Mobil).kapasitasPenumpang),
                  ] else if (widget.kendaraan is Motor) ...[
                    _buildDetailRow("Tipe Mesin", (widget.kendaraan as Motor).tipeMesin),
                    _buildDetailRow("Kapasitas", (widget.kendaraan as Motor).kapasitasMesin),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: isMarketplaceItem
          ? _buildBuyNowButton(context, widget.listing!)
          : null,
    );
  }


  Widget _buildSellerInfoSection(Listing listing) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        color: Colors.grey.shade100,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Informasi Penjual", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildDetailRow("Penjual", listing.sellerEmail),
              _buildDetailRow("Lokasi", listing.location),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBuyNowButton(BuildContext context, Listing listing) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutPage(listing: listing),
            ),
          );
        },
        icon: const Icon(Icons.shopping_cart_checkout),
        label: const Text('Beli Sekarang'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 15, color: Colors.grey.shade600)),
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        children: [
          RatingBar.builder(
            initialRating: _userRating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 28,
            itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) {
              setState(() { _userRating = rating; });
            },
          ),
          const SizedBox(width: 12),
          Text(
            _userRating.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
          )
        ],
      ),
    );
  }
}