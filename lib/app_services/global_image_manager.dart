import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_preferences.dart';


class GlobalImageManager extends ChangeNotifier {
  static final GlobalImageManager _instance = GlobalImageManager._internal();
  bool _disposed = false;


  factory GlobalImageManager() {
    return _instance;
  }


  GlobalImageManager._internal();


  // Profile image path and text data
  String _profileImagePath = '';
  String _textData = '';  // This is the new text field for saving/retrieving text


  // Getters
  String get profileImagePath {
    if (_disposed) {
      throw Exception("GlobalImageManager has been disposed");
    }
    return _profileImagePath;
  }


  String get textData {
    if (_disposed) {
      throw Exception("GlobalImageManager has been disposed");
    }
    return _textData;
  }


  // Load profile image path from SharedPreferences
  Future<void> loadProfileImage() async {
    if (_disposed) {
      throw Exception("GlobalImageManager has been disposed");
    }


    // SharedPreferences prefs = await SharedPreferences.getInstance();
    AppPreferences().getImage();
    // _profileImagePath = prefs.getString('profileImagePath') ?? '';
    if (!_disposed) {
      notifyListeners();
    }
  }


  // Update profile image path and save it in SharedPreferences
  Future<void> updateProfileImage(String imagePath) async {
    if (_disposed) {
      throw Exception("GlobalImageManager has been disposed");
    }


    _profileImagePath = imagePath;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authimage', imagePath);
    // AppPreferences().saveImage(_profileImagePath);
    if (!_disposed) {
      notifyListeners();
    }
  }
  Future<void> removeProfileImage() async {


    if (_disposed) {
      throw Exception("GlobalImageManager has been disposed");
    }


    // AppPreferences().removeImage();
    // Remove profile image path from SharedPreferences
    await AppPreferences().removeImage();


    // Immediately update the profile image path in the class to reflect the removal
    _profileImagePath = '';


    // Notify listeners to update the UI
    if (!_disposed) {
      notifyListeners();
    }
  }


  // Load text data from SharedPreferences
  Future<void> loadText() async {
    if (_disposed) {
      throw Exception("GlobalImageManager has been disposed");
    }


    SharedPreferences prefs = await SharedPreferences.getInstance();
    _textData = prefs.getString('textData') ?? '';  // Load the text string from SharedPreferences
    if (!_disposed) {
      notifyListeners();
    }
  }


  // Update text data and save it in SharedPreferences
  Future<void> updateText(String newText) async {
    if (_disposed) {
      throw Exception("GlobalImageManager has been disposed");
    }


    _textData = newText;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    AppPreferences().saveName(newText);
    // await prefs.setString('textData', newText);  // Save the new text string
    if (!_disposed) {
      notifyListeners();
    }
  }


  // Dispose method
  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }


  // Notify listeners method (prevents notifying after disposal)
  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}



