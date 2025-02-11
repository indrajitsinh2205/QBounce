import 'dart:io';
import '../../app_services/app_preferences.dart';
import '../../app_services/common_Capital.dart';
import '../../network/base_api_configuration/api_end_point.dart';

enum LeaderBoardType { leaderboard, contactUS }

class LeaderBoardApiEndpoint implements APIEndpoint {
  final LeaderBoardType type;
  final Map<String, dynamic>? requestBody;
  final Map<String, dynamic>? requestParam;
  final List<String>? pathParam;
  final String? stringPathParam;

  LeaderBoardApiEndpoint(this.type, {this.requestBody, this.requestParam, this.pathParam, this.stringPathParam});

  // Asynchronous initialization for sessionToken

  @override
  Map<String, dynamic>? get body => requestBody;

  @override
  Map<String, dynamic>? get queryParam => requestParam;

  @override
  Map<String, String> get headers => {
    HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    HttpHeaders.cacheControlHeader: 'no-cache',
    HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
    'Access-Control-Allow-Headers': '*',
    'Access-Control-Allow-Origin': '*',
    'x-session-token': GlobleValue.session.value ?? '',
  };

  @override
  String get baseURL => 'https://qbounce.api.appmatictech.com/api/';

  @override
  String get versionURL => 'v2/';

  @override
  Uri get finalURL => Uri.parse(baseURL + path);

  @override
  String get path {
    switch (type) {
      case LeaderBoardType.leaderboard:
        return 'leaderboard/$stringPathParam';
      case LeaderBoardType.contactUS:
        return 'inquiries/store';
      default:
        return '';
    }
  }

  @override
  HttpMethod get method {
    switch (type) {
      case LeaderBoardType.leaderboard:
        return HttpMethod.GET;
      default:
        return HttpMethod.POST;
    }
  }
}
