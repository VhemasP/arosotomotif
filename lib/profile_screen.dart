import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_screen.dart';
import 'chat_screen.dart';
import 'feedback_screen.dart';
import 'manage_profile_screen.dart';
import 'model/user.dart';
import 'beli_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(user.email),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildGridItem(
            context,
            Icons.shopping_bag,
            'Riwayat Pembelian',
                () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Provider<User>.value(
                  value: user,
                  child: const BeliHistoryScreen(),
                ),
              ),
            ),
          ),
          // DIUBAH DI SINI
          _buildGridItem(
            context,
            Icons.chat_bubble,
            'Chat Admin',
                () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Provider<User>.value(
                  value: user,
                  child: const ChatScreen(),
                ),
              ),
            ),
          ),
          _buildGridItem(
            context,
            Icons.rate_review,
            'Beri Penilaian',
                () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FeedbackScreen())),
          ),
          _buildGridItem(
            context,
            Icons.manage_accounts,
            'Atur Profil',
                () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Provider<User>.value(
                  value: user,
                  child: const ManageProfileScreen(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.blue.shade700),
            const SizedBox(height: 12),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}