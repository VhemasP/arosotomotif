import 'listing.dart';

class Transaction {
  final Listing listing;
  final String buyerEmail;
  final DateTime purchaseDate;

  Transaction({
    required this.listing,
    required this.buyerEmail,
    required this.purchaseDate,
  });
}