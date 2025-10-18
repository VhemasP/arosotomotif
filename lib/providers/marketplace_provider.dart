import 'package:flutter/material.dart';
import '../model/listing.dart';
import '../model/transaction.dart';
import '../model/item_list.dart';

class MarketplaceProvider extends ChangeNotifier {
  final List<Listing> _listings = [];
  final List<Transaction> _transactions = [];

  List<Listing> get listings => _listings;
  List<Transaction> get transactions => _transactions;
  int get totalSales => _transactions.length;

  MarketplaceProvider() {
    _listings.add(
        Listing(
          vehicle: vehicleList[0],
          sellerEmail: 'admin@aros.com',
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

  void purchaseListing(Listing listingToPurchase, String buyerEmail) {
    final transaction = Transaction(
      listing: listingToPurchase,
      buyerEmail: buyerEmail,
      purchaseDate: DateTime.now(),
    );
    _transactions.add(transaction);
    _listings.removeWhere((listing) => listing == listingToPurchase);
    notifyListeners();
  }
}