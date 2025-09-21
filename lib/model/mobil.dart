import 'kendaraan.dart';

class Mobil extends Kendaraan {
  String _tipe;
  String _spekMesin;
  String _kapasitasPenumpang;

  Mobil({
    required super.nama,
    required super.harga,
    required super.imageUrl,
    required String tipe,
    required String spekMesin,
    required String kapasitasPenumpang,
  })  : _tipe = tipe,
        _spekMesin = spekMesin,
        _kapasitasPenumpang = kapasitasPenumpang;

  String get tipe => _tipe;
  String get spekMesin => _spekMesin;
  String get kapasitasPenumpang => _kapasitasPenumpang;

  set tipe(String value) {
    _tipe = value;
  }

  set spekMesin(String value) {
    _spekMesin = value;
  }

  set kapasitasPenumpang(String value) {
    _kapasitasPenumpang = value;
  }

  @override
  String getDeskripsiSingkat() {
    return '$_tipe | $_spekMesin | $_kapasitasPenumpang';
  }
}