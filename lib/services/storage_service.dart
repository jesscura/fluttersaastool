import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  static StorageService get instance => _instance;
  
  StorageService._internal();
  
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // User preferences
  Future<void> setThemeMode(String mode) async {
    await _prefs?.setString('theme_mode', mode);
  }

  String? getThemeMode() {
    return _prefs?.getString('theme_mode');
  }

  // Authentication
  Future<void> setAuthToken(String token) async {
    await _prefs?.setString('auth_token', token);
  }

  String? getAuthToken() {
    return _prefs?.getString('auth_token');
  }

  Future<void> clearAuthToken() async {
    await _prefs?.remove('auth_token');
  }

  // User data
  Future<void> setUserId(String userId) async {
    await _prefs?.setString('user_id', userId);
  }

  String? getUserId() {
    return _prefs?.getString('user_id');
  }

  Future<void> setUserEmail(String email) async {
    await _prefs?.setString('user_email', email);
  }

  String? getUserEmail() {
    return _prefs?.getString('user_email');
  }

  // Clear all data
  Future<void> clearAll() async {
    await _prefs?.clear();
  }
}
