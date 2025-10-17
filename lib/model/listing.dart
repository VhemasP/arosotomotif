import 'kendaraan.dart';

class Listing {
  final Kendaraan vehicle;
  final String sellerEmail;
  final String description;
  final String location;
  final DateTime datePosted;

  Listing({
    required this.vehicle,
    required this.sellerEmail,
    required this.description,
    required this.location,
    required this.datePosted,
  });
}