import 'package:shared_preferences/shared_preferences.dart';

class SharePreferences {
  static const _latitudeKey = 'latitude';
  static const _longitudeKey = 'longitude';


  static Future<void> saveLocation(String latitude, String longitude) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_latitudeKey, latitude);
    await prefs.setString(_longitudeKey, longitude);
  }


  static Future<String?> getLatitude() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_latitudeKey);
  }


  static Future<String?> getLongitude() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_longitudeKey);
  }
}
