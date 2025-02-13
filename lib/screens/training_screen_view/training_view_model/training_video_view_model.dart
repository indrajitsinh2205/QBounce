import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:q_bounce/screens/training_screen_view/training_view_model/TrainingResponse.dart';
import 'package:q_bounce/screens/training_screen_view/training_view_model/TrainingVideoResponse.dart';

import '../../../network/base_api_configuration/api_service.dart';
import '../../../network/training_api_configuration/training_api_endPoint.dart';


class TrainingVideoViewModel extends ChangeNotifier {
  final apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<TrainingVideoResponse?> getTrainingVideo(String query) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    print("response.statusCode ${query}");
    try {
      final endpoint = TrainingApiEndpoint(
        TrainingType.training_video,
        stringPathParam: query,
      );
 
      final response = await apiService.callApi(endpoint);
      print("response.statusCode ${response.statusCode}");
      // print("response.query ${query}");
      if (response.statusCode == 200) {
        print("food ${response.body}");
        // Decode the JSON response to a Map
        final jsonResponse = jsonDecode(response.body);

        // Parse the JSON response into a TrainingResponse object
        TrainingVideoResponse trainingVideoResponse = TrainingVideoResponse.fromJson(jsonResponse);

        print("foods: ${trainingVideoResponse.data}");
        return trainingVideoResponse;
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
