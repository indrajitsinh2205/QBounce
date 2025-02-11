import 'dart:io';

import '../../network/base_api_configuration/api_end_point.dart';


enum LeaderBoardType { leaderboard,contactUS}

class LeaderBoardApiEndpoint implements APIEndpoint {
  String sessionToken = "P8VMqoUXndNfHENZW03hmNocAiKPbWQKdGeRPvpHdOVuN2ViNw0bqIy8ja4ARdoueCBuRdB0i1uCjQF0rE40BalZaOmh2w7Pc89EAaDsaX6TA8UWsZHU7nwXaXW201QV";

  final LeaderBoardType type;
  final Map<String, dynamic>? requestBody;
  final Map<String, dynamic>? requestParam;
  final List<String>? pathParam;
  final String? stringPathParam;

  LeaderBoardApiEndpoint(this.type, {this.requestBody, this.requestParam, this.pathParam,this.stringPathParam});

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
    "x-session-token":sessionToken,
  };

  @override
  String get baseURL =>
      'https://qbounce.api.appmatictech.com/api/';

  @override
  String get versionURL => 'v2/';
  @override
  Uri get finalURL => Uri.parse(baseURL + path);

  @override
  String get path {
    switch (type) {
    // case LeaderBoardType.searchFood:
    //   return  requestParam != null ? 'search/instant/?$requestParam' : 'search/instant';
    // case LeaderBoardType.getFood:
    //   return pathParam != null ? 'search/item/?$pathParam' : 'search/item';
      case LeaderBoardType.leaderboard:
          return 'leaderboard/$stringPathParam';
      case LeaderBoardType.contactUS:
        return 'inquiries/store';

    }
  }

  @override
  HttpMethod get method {
    switch (type) {
      case LeaderBoardType.leaderboard:
        return HttpMethod.GET;
    // case LeaderBoardType.getFood:
    //   return HttpMethod.GET;
    // case LeaderBoardType.getCommonFood:
    //   return HttpMethod.POST;
      default:
        return HttpMethod.POST;
    }
  }
}
