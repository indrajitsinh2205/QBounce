import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:q_bounce/app_services/app_preferences.dart';
import 'package:q_bounce/screens/home_screen_view/user_details_bloc/user_details_response.dart';
import 'package:q_bounce/screens/profile_screen_view/profile_view_model/profile_view_model/profile_endpoint.dart';
import 'package:q_bounce/screens/state_screen_view/statistic_api_endpoint/statistic_api_enpoint.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_view_model/statistics_delete_response.dart';

import '../../../../app_services/global_image_manager.dart';
import '../../../../network/base_api_configuration/api_service.dart';
class UserDetailsViewModel extends ChangeNotifier {
  final apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<UserDetailsResponse?> getUserDetails() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final endpoint = ProfileApiEndpoint(
        ProfileType.userDetails,
      );

      final response = await apiService.callApi(endpoint);
      print("UserDetails.statusCode ${response.statusCode}");
      if (response.statusCode == 200) {
        print("statistics ${response.body}");
        final jsonResponse = jsonDecode(response.body);

        UserDetailsResponse userDetailsResponse = UserDetailsResponse.fromJson(jsonResponse);

        print("statistics: ${userDetailsResponse.data}");
        AppPreferences().saveName(userDetailsResponse.data!.firstName.toString());
        AppPreferences().saveImage(userDetailsResponse.data!.image.toString());
        // GlobalImageManager().updateProfileImage(userDetailsResponse.data?.image ?? '');

        return userDetailsResponse;
      }
      else {
        print("error");
        _errorMessage = 'Error: ${response.body}';
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
