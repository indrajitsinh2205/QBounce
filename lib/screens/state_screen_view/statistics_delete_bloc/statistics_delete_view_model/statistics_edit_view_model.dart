import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:q_bounce/screens/state_screen_view/statistic_api_endpoint/statistic_api_enpoint.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_view_model/statistics_delete_response.dart';

import '../../../../network/base_api_configuration/api_service.dart';
class StatisticsDeleteViewModel extends ChangeNotifier {
  final apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<PostStatisticsDeleteResponse?> getStatisticsDelete(int query) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final endpoint = StatisticsApiEndpoint(
        StatisticsType.statisticsDelete,
        intPathParam: query,
      );

      final response = await apiService.callApi(endpoint);
      print("response.statusCode ${response.statusCode}");
      // print("response.query ${query}");
      if (response.statusCode == 200) {
        print("statistics ${response.body}");
        final jsonResponse = jsonDecode(response.body);

        PostStatisticsDeleteResponse postStatisticsDeleteResponse = PostStatisticsDeleteResponse.fromJson(jsonResponse);

        print("statistics: ${postStatisticsDeleteResponse.data}");
        return postStatisticsDeleteResponse;
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
