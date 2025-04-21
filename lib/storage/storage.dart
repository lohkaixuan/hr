import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final String _userIdKey = "user_id";
  final String _authTokenKey = "auth_token";
  final String _userNameKey = "user_name";

  /// 📌 Save User ID, Name & Token Together
  Future<void> saveUserData(int userId, String userName, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, userId);
    await prefs.setString(_userNameKey, userName);
    await prefs.setString(_authTokenKey, token);
  }

  /// 📌 Get User ID
  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }

  /// 📌 Get User Name
  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  /// 📌 Get JWT Token
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  /// 📌 Clear User Data (Logout)
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.remove(_userNameKey);
    await prefs.remove(_authTokenKey);
  }
}
