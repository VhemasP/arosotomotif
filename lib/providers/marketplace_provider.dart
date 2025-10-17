// lib/providers/marketplace_provider.dart
import 'package:flutter/material.dart';
import '../model/listing.dart';
import '../model/item_list.dart';

class MarketplaceProvider extends ChangeNotifier {
  final List<Listing> _listings = [];

  List<Listing> get listings => _listings;

  MarketplaceProvider() {
    // Data awal untuk contoh
    _listings.add(
        Listing(
          vehicle: vehicleList[0],
          sellerEmail: 'seller1@example.com',
          description: 'Kondisi mulus, jarang dipakai. Servis rutin di dealer resmi.',
          location: 'Magetan',
          datePosted: DateTime.now().subtract(const Duration(days: 2)),
        )
    );
    _listings.add(
        Listing(
          vehicle: vehicleList[2],
          sellerEmail: 'seller2@example.com',
          description: 'Motor rawatan, surat-surat lengkap. Pajak hidup.',
          location: 'Surabaya',
          datePosted: DateTime.now().subtract(const Duration(days: 5)),
        )
    );
  }

  void addListing(Listing newListing) {
    _listings.insert(0, newListing);
    notifyListeners();
  }

  // DITAMBAHKAN: Logika untuk membeli
  void purchaseListing(Listing listingToPurchase) {
    _listings.removeWhere((listing) => listing.vehicle.nama == listingToPurchase.vehicle.nama && listing.sellerEmail == listingToPurchase.sellerEmail);
    notifyListeners();
  }
}