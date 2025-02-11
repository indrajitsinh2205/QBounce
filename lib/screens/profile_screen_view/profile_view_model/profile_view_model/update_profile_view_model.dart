import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:q_bounce/screens/profile_screen_view/profile_view_model/profile_view_model/profile_endpoint.dart';
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

    try {
      final uri = Uri.parse('https://qbounce.api.appmatictech.com/api/user_info'); // Replace with the correct endpoint
      var request = http.MultipartRequest('POST', uri);
      request.headers['x-session-token']="P8VMqoUXndNfHENZW03hmNocAiKPbWQKdGeRPvpHdOVuN2ViNw0bqIy8ja4ARdoueCBuRdB0i1uCjQF0rE40BalZaOmh2w7Pc89EAaDsaX6TA8UWsZHU7nwXaXW201QV";
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
      print(response);
      print(response.statusCode);
      final responseString = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(responseString);
      print("jsonResponse $jsonResponse");
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final jsonResponse = jsonDecode(responseString);

        UpdateProfileResponse updateProfileResponse = UpdateProfileResponse.fromJson(jsonResponse);
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
