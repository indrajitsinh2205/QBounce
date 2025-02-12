import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:q_bounce/screens/state_screen_view/statistic_api_endpoint/statistic_api_enpoint.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_view_model/statistics_delete_response.dart';

import '../../../../network/base_api_configuration/api_service.dart';
import '../../../app_services/app_preferences.dart';
import '../../../app_services/common_Capital.dart';
import '../auth_response_model/confirm_otp_response.dart';
import 'auth_endPoint.dart';
class ConfirmOtpViewModel extends ChangeNotifier {
  final apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<ConfirmOtpResponse?> confirmOTP(Map<String,dynamic> sendData) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final endpoint = AuthApiEndpoint(
        AuthType.getOtp,
        requestBody: sendData,
      );

      final response = await apiService.callApi(endpoint);
      print("response.statusCode ${response.statusCode}");
      // print("response.query ${query}");
      if (response.statusCode == 200) {
        print("statistics ${response.body}");
        final jsonResponse = jsonDecode(response.body);
        ConfirmOtpResponse confirmOtpResponse = ConfirmOtpResponse.fromJson(jsonResponse);
        AppPreferences().saveName(confirmOtpResponse.data!.user!.name.toString());
        AppPreferences().saveEmail(confirmOtpResponse.data!.user!.email.toString());

        GlobleValue.session.value=confirmOtpResponse.data!.sessionToken!;
        print("statistics: ${confirmOtpResponse.data}");
        return confirmOtpResponse;
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
