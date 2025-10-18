import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/listing.dart';
import 'model/user.dart';
import 'providers/marketplace_provider.dart';

class CheckoutScreen extends StatefulWidget {
  final Listing listing;
  const CheckoutScreen({super.key, required this.listing});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedPaymentMethod;
  final List<String> _paymentMethods = ['Transfer Bank', 'COD (Bayar di Tempat)', 'Dompet Digital'];

  void _confirmPurchase() {
    if (_formKey.currentState!.validate()) {
      final buyerEmail = Provider.of<User>(context, listen: false).email;

      Provider.of<MarketplaceProvider>(context, listen: false).purchaseListing(widget.listing, buyerEmail);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) => AlertDialog(
          title: const Text('Pembelian Berhasil!'),
          content: Text('Anda telah berhasil membeli ${widget.listing.vehicle.nama}. Penjual (${widget.listing.sellerEmail}) akan segera menghubungi Anda.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).popUntil((route) => route.isFirst);
              },
              child: const Text('Kembali ke Home'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap lengkapi semua data yang diperlukan.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          // DITAMBAHKAN: Validasi otomatis saat pengguna berinteraksi
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCard(),
              const SizedBox(height: 24),
              _buildShippingDetails(),
              const SizedBox(height: 24),
              _buildPaymentMethod(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildConfirmButton(),
    );
  }

  Widget _buildSummaryCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Ringkasan Pembelian", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListTile(
              leading: Image.asset(widget.listing.vehicle.imageUrl, width: 80),
              title: Text(widget.listing.vehicle.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                widget.listing.vehicle.harga,
                style: TextStyle(fontSize: 16, color: Colors.blue.shade800, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShippingDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Detail Pengiriman", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Nama Penerima', border: OutlineInputBorder()),
          validator: (value) => value == null || value.isEmpty ? 'Nama tidak boleh kosong' : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Alamat Lengkap', border: OutlineInputBorder()),
          maxLines: 3,
          validator: (value) => value == null || value.isEmpty ? 'Alamat tidak boleh kosong' : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Nomor Telepon', border: OutlineInputBorder()),
          keyboardType: TextInputType.phone,
          validator: (value) => value == null || value.isEmpty ? 'Nomor telepon tidak boleh kosong' : null,
        ),
      ],
    );
  }

  Widget _buildPaymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Metode Pembayaran", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedPaymentMethod,
          hint: const Text('Pilih metode pembayaran...'),
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: _paymentMethods.map((String method) {
            return DropdownMenuItem<String>(value: method, child: Text(method));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedPaymentMethod = newValue;
            });
          },
          validator: (value) => value == null ? 'Metode pembayaran harus dipilih' : null,
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: _confirmPurchase,
        icon: const Icon(Icons.shopping_cart_checkout),
        label: const Text('Konfirmasi Pembelian'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}