import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat_screen.dart';
import 'model/user.dart';
import 'providers/marketplace_provider.dart';
import 'sales_hisrory_screen.dart';
import 'sell_vehicle_page.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    final user = Provider.of<User>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang, Admin ${user.email}!',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildStatCard('Total Penjualan', marketplaceProvider.totalSales.toString(), Icons.point_of_sale, Colors.green)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard('Listing Aktif', marketplaceProvider.listings.length.toString(), Icons.store, Colors.blue)),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Aksi Cepat',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const Divider(),
            const SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.add_circle, color: Colors.indigo.shade700),
              title: const Text('Tambahkan Kendaraan Baru'),
              subtitle: const Text('Terbitkan iklan di marketplace'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SellVehiclePage(userEmail: user.email),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt, color: Colors.indigo.shade700),
              title: const Text('Lihat Riwayat Penjualan'),
              subtitle: Text('${marketplaceProvider.transactions.length} item telah terjual'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SalesHistoryPage()),
                );
              },
            ),
            // DIUBAH DI SINI
            ListTile(
              leading: Icon(Icons.support_agent, color: Colors.indigo.shade700),
              title: const Text('Chat Bantuan Pengguna'),
              subtitle: const Text('Lihat dan balas pesan dari pengguna'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Provider<User>.value(
                      value: user,
                      child: const ChatScreen(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}