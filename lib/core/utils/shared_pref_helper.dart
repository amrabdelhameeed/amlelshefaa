import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBool(
      {required String key, required bool value}) async {
    init();
    return await sharedPreferences!.setBool(key, value);
  }

  static bool getBool({required String key}) {
    init();
    return sharedPreferences!.getBool(key) ?? false;
  }

  static Future<bool> putStr(
      {required String key, required String value}) async {
    init();
    return await sharedPreferences!.setString(key, value);
  }

  static String getStr({required String key}) {
    init();
    return sharedPreferences!.getString(key) ?? "";
  }

  static Future<bool> putlstStr(
      {required String key, required List<String> value}) async {
    init();
    return await sharedPreferences!.setStringList(key, value);
  }

  static List<String> getlstStr({required String key}) {
    init();
    return sharedPreferences!.getStringList(key) ?? [];
  }

  static Future<bool> deleteSharedPref() {
    return sharedPreferences!.clear();
  }

  // put any value
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }

// remove any key
  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }
}
