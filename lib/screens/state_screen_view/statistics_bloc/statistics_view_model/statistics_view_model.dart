import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:q_bounce/screens/state_screen_view/statistic_api_endpoint/statistic_api_enpoint.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_view_model/GetStatisticsResponse.dart';
import 'package:q_bounce/screens/training_screen_view/training_view_model/TrainingVideoResponse.dart';

import '../../../../network/base_api_configuration/api_service.dart';




class StatisticsViewModel extends ChangeNotifier {
  final apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<GetStatisticsResponse?> getStatistics() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final endpoint = StatisticsApiEndpoint(
        StatisticsType.statistics,
        // requestBody: query,
      );

      final response = await apiService.callApi(endpoint);
      print("response.statusCode ${response.statusCode}");
      // print("response.query ${query}");
      if (response.statusCode == 200) {
        print("statistics ${response.body}");
        // Decode the JSON response to a Map
        final jsonResponse = jsonDecode(response.body);

        // Parse the JSON response into a TrainingResponse object
        GetStatisticsResponse getStatisticsResponse = GetStatisticsResponse.fromJson(jsonResponse);

        print("statistics: ${getStatisticsResponse.data}");
        return getStatisticsResponse;
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
