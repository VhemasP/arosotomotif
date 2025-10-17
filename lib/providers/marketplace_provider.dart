import 'package:flutter/material.dart';
import '../model/listing.dart';
import '../model/item_list.dart';

class MarketplaceProvider extends ChangeNotifier {
  final List<Listing> _listings = [];
  final List<Listing> _soldItems = [];

  List<Listing> get listings => _listings;
  List<Listing> get soldItems => _soldItems;
  int get totalSales => _soldItems.length;

  MarketplaceProvider() {
    _listings.add(
        Listing(
          vehicle: vehicleList[0],
          sellerEmail: 'seller1@example.com',
          description: 'Kondisi mulus, jarang dipakai. Servis rutin.',
          location: 'Magetan',
          datePosted: DateTime.now().subtract(const Duration(days: 2)),
        )
    );
    _listings.add(
        Listing(
          vehicle: vehicleList[2],
          sellerEmail: 'seller2@example.com',
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

  void purchaseListing(Listing listingToPurchase) {
    _soldItems.add(listingToPurchase);
    _listings.removeWhere((listing) => listing.vehicle.nama == listingToPurchase.vehicle.nama && listing.sellerEmail == listingToPurchase.sellerEmail);
    notifyListeners();
  }
}