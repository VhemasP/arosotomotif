import 'kendaraan.dart';

class Motor extends Kendaraan {
  String _tipeMesin;
  String _kapasitasMesin;

  Motor({
    required super.nama,
    required super.harga,
    required super.imageUrl,
    required String tipeMesin,
    required String kapasitasMesin,
  })  : _tipeMesin = tipeMesin,
        _kapasitasMesin = kapasitasMesin;

  String get tipeMesin => _tipeMesin;
  String get kapasitasMesin => _kapasitasMesin;

  set tipeMesin(String value) {
    _tipeMesin = value;
  }

  set kapasitasMesin(String value) {
    _kapasitasMesin = value;
  }

  @override
  String getDeskripsiSingkat() {
    return '$_tipeMesin | $_kapasitasMesin';
  }
}