import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String emailKey = 'email';
  static const String passwordKey = 'password';
  static const String nameKey = 'name';
  static const String addressKey = 'address';
  static const String mobilenumberKey = 'mobilenumber';
  static const String instituteKey = 'instituteName';

  static var userName = "";

  // Method to save username to shared preferences
  static Future<void> saveLoginInfo(String email,String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(emailKey, email);
    await prefs.setString(passwordKey, password);
  }

  // Method to get username from shared preferences
  static Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey) ?? "";
  }

  static Future<String?> getPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(passwordKey);
  }

  // Method to clear username from shared preferences
  static Future<void> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> saveUserInfo(String name,String address,String mobileNumber,String institute) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(nameKey, name);
    await prefs.setString(addressKey, address);
    await prefs.setString(mobilenumberKey, mobileNumber);
    await prefs.setString(instituteKey, institute);
  }

  static Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(nameKey) ?? "";
  }

  static Future<String> getAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(addressKey) ?? "";
  }

  static Future<String> getMobileNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(mobilenumberKey) ?? "";
  }

  static Future<String> getInstitute() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(instituteKey) ?? "";
  }

  // static bool adminLoginInfo(String email, String password) {
  //   return email == 'admin@gmail.com' && password == '12345';
  // }

}