import 'kendaraan.dart';
import 'mobil.dart';
import 'motor.dart';

final List<Kendaraan> vehicleList = [
  Mobil(
    nama: "Toyota GR Supra",
    tipe: "Sports Car",
    spekMesin: "3.0L Turbo",
    kapasitasPenumpang: "2 Seater",
    harga: "Rp 2.1 Milyar",
    imageUrl: "https://toyotamobile.id/wp-content/uploads/2023/01/SUPRA-LIGHTNING-YELLOW.webp",
  ),
  Mobil(
    nama: "Honda Civic Type R",
    tipe: "Hot Hatch",
    spekMesin: "2.0L VTEC Turbo",
    kapasitasPenumpang: "4 Seater",
    harga: "Rp 1.4 Milyar",
    imageUrl: "https://vehicle-images.dealerinspire.com/stock-images/thumbnails/large/chrome/7ca9962a6625ebdf02990b0f11972b3e.png",
  ),
  Motor(
    nama: "Kawasaki Ninja ZX-25R",
    tipeMesin: "4-silinder DOHC",
    kapasitasMesin: "250cc",
    harga: "Rp 107 Juta",
    imageUrl: "https://kawasaki-global-admin.com/ContentStorage/KMI/Products/5048/9b170205-e2b5-49f4-a84b-9e9ab36b6c35.png?w=600",
  ),
  Motor(
    nama: "Yamaha XMAX",
    tipeMesin: "4-silinder DOHC",
    kapasitasMesin: "250cc",
    harga: "Rp 88 Juta",
    imageUrl: "https://promoyamahasukabumi.com/wp-content/uploads/2023/03/XMAX-MERAH.png",
  ),
];