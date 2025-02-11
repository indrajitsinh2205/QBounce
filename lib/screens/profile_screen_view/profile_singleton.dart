import 'package:flutter/cupertino.dart';
import 'package:q_bounce/screens/profile_screen_view/profile_view_model/profile_response_model/profile_request_model.dart';

class ProfileNotifier with ChangeNotifier {
  // Assuming `profile` is an instance of UpdateProfileRequest
  UpdateProfileRequest profile = UpdateProfileRequest(
    firstName: '',
    lastName: '',
    country: '',
    jerseyNumber: 0,
    gender: 'Male',
    team: 'hawks',
    instagram: '',
    position: 'Power Forward',
    image: ''
  );

  void updateField(String key, dynamic value) {
    // Update the field based on the key and the value
    if (value is UpdateProfileRequest) {
      profile = value;
      notifyListeners();
    }
  }
}
class ProfileData {
  static final ProfileData _instance = ProfileData._internal();

  factory ProfileData() {
    return _instance;
  }

  ProfileData._internal();

  UpdateProfileRequest? updateProfileRequest;
}