import 'package:flutter/material.dart';
import '../model/listing.dart';
import '../model/transaction.dart'; // Import model baru
import '../model/item_list.dart';

class MarketplaceProvider extends ChangeNotifier {
  final List<Listing> _listings = [];
  final List<Transaction> _transactions = []; // DIUBAH: Melacak transaksi

  List<Listing> get listings => _listings;
  List<Transaction> get transactions => _transactions; // DIUBAH: Getter untuk transaksi
  int get totalSales => _transactions.length;

  MarketplaceProvider() {
    // Data awal untuk contoh
    _listings.add(
        Listing(
          vehicle: vehicleList[0],
          sellerEmail: 'admin@aros.com', // Ubah penjual menjadi admin untuk contoh
          description: 'Kondisi mulus, jarang dipakai. Servis rutin.',
          location: 'Magetan',
          datePosted: DateTime.now().subtract(const Duration(days: 2)),
        )
    );
    _listings.add(
        Listing(
          vehicle: vehicleList[2],
          sellerEmail: 'seller1@example.com',
          description: 'Motor rawatan, surat-surat lengkap.',
          location: 'Surabaya',
          datePosted: DateTime.now().subtract(const Duration(days: 5)),
        )
    );
  }

  void addListing(Listing newListing) {
    _listings.insert(0, newListing);
    notifyListeners();
  }

  // DIUBAH: Logika membeli sekarang membuat objek Transaction
  void purchaseListing(Listing listingToPurchase, String buyerEmail) {
    final transaction = Transaction(
      listing: listingToPurchase,
      buyerEmail: buyerEmail,
      purchaseDate: DateTime.now(),
    );
    _transactions.add(transaction); // Tambahkan ke riwayat transaksi
    _listings.removeWhere((listing) => listing == listingToPurchase);
    notifyListeners();
  }
}