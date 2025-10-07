import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  List<String> _favoriteVehicleIds = [];
  late SharedPreferences _prefs;

  List<String> get favoriteVehicleIds => _favoriteVehicleIds;

  FavoritesProvider() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadFavorites();
  }

  void _loadFavorites() {
    _favoriteVehicleIds = _prefs.getStringList('favoriteVehicles') ?? [];
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    await _prefs.setStringList('favoriteVehicles', _favoriteVehicleIds);
  }

  bool isFavorite(String vehicleId) {
    return _favoriteVehicleIds.contains(vehicleId);
  }

  void toggleFavorite(String vehicleId) {
    if (isFavorite(vehicleId)) {
      _favoriteVehicleIds.remove(vehicleId);
    } else {
      _favoriteVehicleIds.add(vehicleId);
    }
    _saveFavorites();
    notifyListeners();
  }
}