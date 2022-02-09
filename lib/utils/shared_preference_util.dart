import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil{
  static const String accessToken = 'accessToken';
  Future<bool> setStringSharePreference(
      {required String key, required String value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(key, value);
  }

  Future<bool> removeStringSharePreference({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove(key);
  }

  Future<String?> getStringSharePreference({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(key);
  }
}