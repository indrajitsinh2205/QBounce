import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../network/base_api_configuration/api_service.dart';
import '../../../network/training_api_configuration/leader_board_api_endPoint.dart';
import '../../../network/training_api_configuration/training_api_endPoint.dart';
import 'LeaderBoardResponse.dart';


class LeaderBoardViewModel extends ChangeNotifier {
  final apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<LeaderBoardResponse?> getLeaderBoard(String query) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final endpoint = LeaderBoardApiEndpoint(
        LeaderBoardType.leaderboard,
        stringPathParam: query,
      );
      print(endpoint);
      final response = await apiService.callApi(endpoint);
      print("response.statusCode ${response.statusCode}");
      // print("response.query ${query}");
      if (response.statusCode == 200) {
        print("food ${response.body}");
        // Decode the JSON response to a Map
        final jsonResponse = jsonDecode(response.body);

        // Parse the JSON response into a TrainingResponse object
        LeaderBoardResponse leaderBoardResponse = LeaderBoardResponse.fromJson(jsonResponse);

        print("foods: ${leaderBoardResponse.data}");
        return leaderBoardResponse;
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
