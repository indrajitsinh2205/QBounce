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
  static final ProfileData instance = ProfileData._internal();

  factory ProfileData() {
    return instance;
  }

  ProfileData._internal();

  // variables and their default values

  String firstName = "";
  String lastName = "";
  String jerseyNumber = "";

  String selectedGender = 'Male';
  String selectedTeam = 'hawks';
  String selectedPosition = 'Power Forward';
  String selectedCountry = 'Haiti';

  String instagramHandler = '1';

  String image = "";

  UpdateProfileRequest? updateProfileRequest;


  // GENERATE REQUEST MODEL
  void getUpdateProfileRequest() {

    final updatedProfileRequest = UpdateProfileRequest(
      firstName: firstName,
      lastName: lastName,
      country: selectedCountry,
      jerseyNumber: int.tryParse(jerseyNumber) ?? 0,
      gender: selectedGender,
      team: selectedTeam,
      instagram: instagramHandler,
      position: selectedPosition,
      image: image,
    );

    // Update the ProfileData singleton
    updateProfileRequest = updatedProfileRequest;

    // Print the updated request
    print('Saved Profile Request: ${updateProfileRequest?.toJson()}');

  }

}