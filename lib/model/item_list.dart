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
    imageUrl: "assets/images/Supra.jpg",
  ),
  Mobil(
    nama: "Mitsubishi Pajero Sport",
    tipe: "SUV",
    spekMesin: "2.4L Diesel",
    kapasitasPenumpang: "7 Seater",
    harga: "Rp 740 Juta",
    imageUrl: "assets/images/pajero.jpg",
  ),
  Mobil(
    nama: "Honda Civic Type R",
    tipe: "Hot Hatch",
    spekMesin: "2.0L VTEC Turbo",
    kapasitasPenumpang: "4 Seater",
    harga: "Rp 1.4 Milyar",
    imageUrl: "assets/images/civic.jpg",
  ),
  Mobil(
    nama: "Hyundai Ioniq 5",
    tipe: "Electric Crossover",
    spekMesin: "72.6 kWh",
    kapasitasPenumpang: "5 Seater",
    harga: "Rp 860 Juta",
    imageUrl: "assets/images/ioniq.jpg",
  ),
  Mobil(
    nama: "Lamborghini Aventador",
    tipe: "Supercar",
    spekMesin: "6.5L V12",
    kapasitasPenumpang: "2 Seater",
    harga: "Rp 9 Milyar",
    imageUrl: "assets/images/lamborgini.jpg",
  ),

  // MOTOR
  Motor(
    nama: "Kawasaki Ninja ZX-25R",
    tipeMesin: "4-silinder DOHC",
    kapasitasMesin: "250cc",
    harga: "Rp 107 Juta",
    imageUrl: "assets/images/ninja.jpg",
  ),
  Motor(
    nama: "Yamaha NMAX",
    tipeMesin: "1-silinder SOHC",
    kapasitasMesin: "155cc",
    harga: "Rp 35 Juta",
    imageUrl: "assets/images/nmax.jpg",
  ),
  Motor(
    nama: "Honda CBR250RR",
    tipeMesin: "2-silinder DOHC",
    kapasitasMesin: "250cc",
    harga: "Rp 75 Juta",
    imageUrl: "assets/images/cbr.jpg",
  ),
  Motor(
    nama: "Vespa Primavera",
    tipeMesin: "i-get, 1-silinder",
    kapasitasMesin: "150cc",
    harga: "Rp 50 Juta",
    imageUrl: "assets/images/vespa.jpg",
  ),
  Motor(
    nama: "Ducati Panigale V4",
    tipeMesin: "V4, Desmosedici Stradale",
    kapasitasMesin: "1,103cc",
    harga: "Rp 799 Juta",
    imageUrl: "assets/images/panigale.jpg",
  ),
];