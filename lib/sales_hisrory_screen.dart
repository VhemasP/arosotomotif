import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/marketplace_provider.dart';
import 'package:intl/intl.dart';

class SalesHistoryPage extends StatelessWidget {
  const SalesHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<MarketplaceProvider>(context).transactions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Penjualan'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: transactions.isEmpty
          ? const Center(child: Text('Belum ada penjualan yang terjadi.'))
          : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tx = transactions[index];
          final formattedDate = DateFormat('d MMM yyyy, HH:mm').format(tx.purchaseDate);

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Image.asset(tx.listing.vehicle.imageUrl, width: 70, fit: BoxFit.cover),
              title: Text(tx.listing.vehicle.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Penjual: ${tx.listing.sellerEmail}'),
                  Text('Pembeli: ${tx.buyerEmail}'),
                  Text('Waktu: $formattedDate'),
                ],
              ),
              trailing: Text(tx.listing.vehicle.harga, style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold)),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}