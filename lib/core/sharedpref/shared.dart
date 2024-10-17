import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  /// Initialize SharedPreferences instance
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Put and get int
  static Future<bool> putInt({required String key, required int value}) async {
    return await sharedPreferences.setInt(key, value);
  }

  static int getInt(String key) {
    return sharedPreferences.getInt(key) ?? 0;
  }

  // Put and get String
  static Future<bool> putString({required String key, required String value}) async {
    return await sharedPreferences.setString(key, value);
  }

  static String getString(String key) {
    return sharedPreferences.getString(key) ?? "";
  }

  // Put and get bool
  static Future<bool> putBool({required String key, required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  static bool getBool(String key) {
    return sharedPreferences.getBool(key) ?? false;
  }

  // Put and get double
  static Future<bool> putDouble({required String key, required double value}) async {
    return await sharedPreferences.setDouble(key, value);
  }

  static double getDouble(String key) {
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  // Put and get List<String>
  static Future<bool> putListString(String key, List<String> value) async {
    return await sharedPreferences.setStringList(key, value);
  }

  static List<String>? getListString(String key) {
    return sharedPreferences.getStringList(key);
  }

  // Remove a specific key
  static Future<bool> remove(String key) async {
    return await sharedPreferences.remove(key);
  }

  // Clear all keys
  static Future<bool> clear() async {
    return await sharedPreferences.clear();
  }
}