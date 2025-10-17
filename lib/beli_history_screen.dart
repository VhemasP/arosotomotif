import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/user.dart';
import 'providers/marketplace_provider.dart';

class BeliHistoryScreen extends StatelessWidget {
  const BeliHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final marketplace = Provider.of<MarketplaceProvider>(context);
    final myPurchases = marketplace.transactions.where((t) => t.buyerEmail == user.email).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pembelian'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: myPurchases.isEmpty
          ? const Center(child: Text('Anda belum pernah membeli apapun.'))
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: myPurchases.length,
        itemBuilder: (ctx, i) => Card(
          child: ListTile(
            leading: Image.asset(myPurchases[i].listing.vehicle.imageUrl, width: 70, fit: BoxFit.cover),
            title: Text(myPurchases[i].listing.vehicle.nama),
            subtitle: Text('Dibeli dari: ${myPurchases[i].listing.sellerEmail}'),
            trailing: Text(myPurchases[i].listing.vehicle.harga),
          ),
        ),
      ),
    );
  }
}