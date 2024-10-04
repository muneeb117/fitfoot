import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_constant.dart';

class StorageServices {
  late final SharedPreferences _preferences;

  Future<StorageServices> init() async {
    _preferences = await SharedPreferences.getInstance();
    return this;
  }

  // Set and Get for bool values
  Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  // Set and Get for string values
  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  // Get for string values
  String? getString(String key) {
    return _preferences.getString(key);
  }

  // Get if the device opened the first time
  bool getDeviceFirstOpen() {
    return _preferences.getBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME) ??
        false;
  }

  // Check if the user is logged in
  bool getIsLoggedIn() {
    return _preferences.getString(AppConstants.STORAGE_USER_TOKEN_KEY) != null;
  }

  // Remove any specific key
  Future<bool> remove(String key) {
    return _preferences.remove(key);
  }

  // Logout functionality
  Future<void> logout() async {
    await remove(AppConstants.STORAGE_USER_TOKEN_KEY);
  }

  // New Methods for storing and retrieving user type
}
