import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:q_bounce/screens/training_screen_view/training_view_model/TrainingVideoResponse.dart';

import '../../../network/base_api_configuration/api_service.dart';
import '../../../network/training_api_configuration/training_api_endPoint.dart';
import 'TrainingProgress.dart';


class TrainingProgressViewModel extends ChangeNotifier {
  final apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<TrainingProgressResponse?> postTrainingProgress(Map<String,dynamic> query) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final endpoint = TrainingApiEndpoint(
        TrainingType.trainingProgress,
         requestBody: query,
      );

      final response = await apiService.callApi(endpoint);
      print("response.statusCode ${response.statusCode}");
      // print("response.query ${query}");
      if (response.statusCode == 200) {
        print("food ${response.body}");
        // Decode the JSON response to a Map
        final jsonResponse = jsonDecode(response.body);

        // Parse the JSON response into a TrainingResponse object
        TrainingProgressResponse trainingProgressResponse = TrainingProgressResponse.fromJson(jsonResponse);

        print("foods: ${trainingProgressResponse.data}");
        return trainingProgressResponse;
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
