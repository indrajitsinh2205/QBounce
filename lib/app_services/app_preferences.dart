import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
static  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    print("Token saved to SharedPreferences: $token");
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    print("Token removed from SharedPreferences.");
  }

  Future<void> saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_name', name);
    print("Token saved to SharedPreferences: $name");
  }
  Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_name');
  }
  Future<void> removeName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_name');
    print("auth_name remove to SharedPreferences");
  }
  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_email', email);
    print("Token saved to SharedPreferences: $email");
  }
  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_email');
  }
  Future<void> removeEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_email');
    print("auth_email remove to SharedPreferences");
  }

  Future<void> saveImage(String image) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_image', image);
      print("auth_image saved to SharedPreferences: $image");
    } catch (e) {
      print("Failed to save auth_image to SharedPreferences: $e");
    }
  }

  Future<String?> getImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final image = prefs.getString('auth_image');
      print("auth_image retrieved from SharedPreferences: $image");
      return image;
    } catch (e) {
      print("Failed to retrieve auth_image from SharedPreferences: $e");
      return null;
    }
  }

  Future<void> removeImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_image');
      print("auth_image removed from SharedPreferences.");
    } catch (e) {
      print("Failed to remove auth_image from SharedPreferences: $e");
    }
  }

}