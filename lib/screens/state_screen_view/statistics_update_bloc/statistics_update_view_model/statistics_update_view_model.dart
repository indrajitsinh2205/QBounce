import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:q_bounce/screens/state_screen_view/statistic_api_endpoint/statistic_api_enpoint.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_view_model/PostStatisticsUpdateResponse.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_view_model/post_statistics_update_request.dart';

import '../../../../network/base_api_configuration/api_service.dart';




class StatisticsUpdateViewModel extends ChangeNotifier {
  final apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<PostStatisticsUpdateResponse?> postStatisticsUpdate(int query,PostStatisticsUpdateRequestRequestModel postData) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final endpoint = StatisticsApiEndpoint(
        StatisticsType.statisticsUpdate,
        intPathParam: query,
        requestBody: postData.toJson(),
      );

      final response = await apiService.callApi(endpoint);
      print("response.statusCode ${response.statusCode}");
      // print("response.query ${query}");
      if (response.statusCode == 200) {
        print("statistics ${response.body}");
        // Decode the JSON response to a Map
        final jsonResponse = jsonDecode(response.body);

        // Parse the JSON response into a TrainingResponse object
        PostStatisticsUpdateResponse postStatisticsUpdateResponse = PostStatisticsUpdateResponse.fromJson(jsonResponse);

        print("statistics: ${postStatisticsUpdateResponse.data}");
        return postStatisticsUpdateResponse;
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
