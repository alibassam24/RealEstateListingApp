import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Save the list of favorite property IDs
  static Future<void> saveFavorites(List<String> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', favorites);
  }

  // Load the list of favorite property IDs
  static Future<List<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }
}
