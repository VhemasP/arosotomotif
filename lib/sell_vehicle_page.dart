import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/item_list.dart';
import 'model/kendaraan.dart';
import 'model/listing.dart';
import 'providers/marketplace_provider.dart';

class SellVehiclePage extends StatefulWidget {
  final String userEmail;
  const SellVehiclePage({super.key, required this.userEmail});

  @override
  State<SellVehiclePage> createState() => _SellVehiclePageState();
}

class _SellVehiclePageState extends State<SellVehiclePage> {
  final _formKey = GlobalKey<FormState>();
  Kendaraan? _selectedVehicle;
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  void _submitListing() {
    if (_formKey.currentState!.validate()) {
      if (_selectedVehicle == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Silakan pilih kendaraan terlebih dahulu.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final newListing = Listing(
        vehicle: _selectedVehicle!,
        sellerEmail: widget.userEmail,
        description: _descriptionController.text,
        location: _locationController.text,
        datePosted: DateTime.now(),
      );

      Provider.of<MarketplaceProvider>(context, listen: false).addListing(newListing);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kendaraan Anda berhasil ditambahkan ke marketplace!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jual Kendaraan Anda'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("Pilih Kendaraan dari Katalog", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<Kendaraan>(
                value: _selectedVehicle,
                hint: const Text('Pilih kendaraan...'),
                isExpanded: true,
                items: vehicleList.map((Kendaraan vehicle) {
                  return DropdownMenuItem<Kendaraan>(
                    value: vehicle,
                    child: Text(vehicle.nama),
                  );
                }).toList(),
                onChanged: (Kendaraan? newValue) {
                  setState(() {
                    _selectedVehicle = newValue;
                  });
                },
                validator: (value) => value == null ? 'Kendaraan harus dipilih' : null,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 24),
              const Text("Detail Iklan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  hintText: 'Contoh: Kondisi mulus, jarang dipakai...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) => value == null || value.isEmpty ? 'Deskripsi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Lokasi',
                  hintText: 'Contoh: Magetan',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_pin),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Lokasi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _submitListing,
                icon: const Icon(Icons.publish),
                label: const Text('Terbitkan Iklan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}