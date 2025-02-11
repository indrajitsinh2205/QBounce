import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:q_bounce/screens/sign_in_screen_view/auth_view_model/auth_endPoint.dart';
import 'package:q_bounce/screens/sign_in_screen_view/sign_out_bloc/sign_out_response.dart';
import 'package:q_bounce/screens/state_screen_view/statistic_api_endpoint/statistic_api_enpoint.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_view_model/statistics_delete_response.dart';

import '../../../../network/base_api_configuration/api_service.dart';
class SignOutViewModel extends ChangeNotifier {
  final apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<SignOutResponse?> SignOut ()async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final endpoint = AuthApiEndpoint(
        AuthType.signOut,
      );

      final response = await apiService.callApi(endpoint);
      print("response.statusCode ${response.statusCode}");
      // print("response.query ${query}");
      if (response.statusCode == 200) {
        print("statistics ${response.body}");
        final jsonResponse = jsonDecode(response.body);

        SignOutResponse signOutResponse = SignOutResponse.fromJson(jsonResponse);

        print("statistics: ${signOutResponse.data}");
        return signOutResponse;
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
