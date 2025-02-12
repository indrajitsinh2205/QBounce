import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../../../app_services/app_preferences.dart';
import '../../../../app_services/common_Capital.dart';
import '../../../../network/base_api_configuration/api_service.dart';
import '../profile_response_model/get_profile_response.dart';
import '../profile_response_model/profile_request_model.dart';
import '../profile_response_model/update_proifle_response.dart';

class UpdateProfileViewModel extends ChangeNotifier {
  final apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<UpdateProfileResponse?> updateProfile(UpdateProfileRequest data, File? imageFile) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    String? sessionToken = await AppPreferences().getToken();
    if (sessionToken == null) {
      throw Exception('No session token found');
    }

    try {
      final uri = Uri.parse('https://qbounce.api.appmatictech.com/api/user_info'); // Replace with the correct endpoint
      var request = http.MultipartRequest('POST', uri);
      request.headers['x-session-token'] = GlobleValue.session.value;

      // Adding text fields to the multipart request
      request.fields['first_name'] = data.firstName ?? '';
      request.fields['last_name'] = data.lastName ?? '';
      request.fields['jersey_number'] = data.jerseyNumber.toString();
      request.fields['instagram'] = data.instagram ?? '';
      request.fields['gender'] = data.gender ?? 'Male';
      request.fields['team'] = data.team ?? 'hawks';
      request.fields['position'] = data.position ?? 'Power Forward';
      request.fields['country'] = data.country ?? 'Haiti';

      // Adding image file to the multipart request (if available)
      if (imageFile != null) {
        var image = await http.MultipartFile.fromPath('image', imageFile.path);
        request.files.add(image);
      }

      // Send request
      final response = await request.send();
      // final responseString = await response.stream.bytesToString();
      // final jsonResponse = jsonDecode(responseString);
      // print("jsonResponse $jsonResponse");
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final jsonResponse = jsonDecode(responseString);
        // Assuming your response model expects data in the format: {is_error: bool, data: [], message: string}
        final updateProfileResponse = UpdateProfileResponse.fromJson(jsonResponse);
        print("updateProfileResponse: $updateProfileResponse");
        return updateProfileResponse;
      } else {
        _errorMessage = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }
}
