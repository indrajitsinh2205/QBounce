import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/screens/home_screen_view/get_level_profile_view_model.dart';
import 'package:q_bounce/screens/profile_screen_view/profile_view_model/profile_response_model/profile_request_model.dart';
import 'package:q_bounce/screens/training_screen_view/training_view_model/TrainingResponse.dart';
import 'package:q_bounce/screens/training_screen_view/training_view_model/TrainingVideoResponse.dart';

import '../home_screen_view/get_level_profile_view_model/get_level_profile_response.dart';
import '../training_screen_view/training_program_bloc/training_program_bloc.dart';
import '../training_screen_view/training_program_bloc/training_program_event.dart';
import '../training_screen_view/training_view_model/training_view_model.dart';

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

class LevelModuleDataHandler {
  static final LevelModuleDataHandler instance = LevelModuleDataHandler._internal();

  factory LevelModuleDataHandler() {
    return instance;
  }

  LevelModuleDataHandler._internal();


  LevelData  levelData = LevelData();

  Map<String,TrainingResponse> trainingDataMap ={};
  Map<String,TrainingVideoResponse> videoDataMap ={};



Future<TrainingResponse?> fetchTrainingData ( String type) async {
    if (trainingDataMap.containsKey(type)){
      return trainingDataMap[type];
    }else{

      return null;

    }
  }
  Future<TrainingVideoResponse?> fetchVideoTrainingData ( String type) async {
    if (videoDataMap.containsKey(type)){
      return videoDataMap[type];
    }else{

      return null;

    }
  }
}
