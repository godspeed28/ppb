import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const String _keyUser = "username";
  static const String _keyPass = "password";

  static Future<void> saveUser(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUser, username);
    await prefs.setString(_keyPass, password);
  }

  static Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedUser = prefs.getString(_keyUser);
    final savedPass = prefs.getString(_keyPass);
    return (username == savedUser && password == savedPass);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_keyUser);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
