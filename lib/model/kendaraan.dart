abstract class Kendaraan {
  String nama;
  String harga;
  String imageUrl;

  Kendaraan({
    required this.nama,
    required this.harga,
    required this.imageUrl,
  });

  String getDeskripsiSingkat();
}