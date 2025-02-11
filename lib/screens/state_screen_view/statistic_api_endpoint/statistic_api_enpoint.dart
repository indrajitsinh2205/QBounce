import 'dart:io';

import '../../../network/base_api_configuration/api_end_point.dart';



enum StatisticsType { statistics,statisticsStore,statisticsEdit,statisticsUpdate,statisticsDelete}

class StatisticsApiEndpoint implements APIEndpoint {
  String sessionToken = "P8VMqoUXndNfHENZW03hmNocAiKPbWQKdGeRPvpHdOVuN2ViNw0bqIy8ja4ARdoueCBuRdB0i1uCjQF0rE40BalZaOmh2w7Pc89EAaDsaX6TA8UWsZHU7nwXaXW201QV";

  final StatisticsType type;
  final Map<String, dynamic>? requestBody;
  final Map<String, dynamic>? requestParam;
  final List<String>? pathParam;
  final String? stringPathParam;
  final int? intPathParam;

  StatisticsApiEndpoint(this.type,  {this.requestBody, this.requestParam,this.intPathParam, this.pathParam,this.stringPathParam});

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
    // case TrainingType.searchFood:
    //   return  requestParam != null ? 'search/instant/?$requestParam' : 'search/instant';
    // case TrainingType.getFood:
    //   return pathParam != null ? 'search/item/?$pathParam' : 'search/item';
      case StatisticsType.statistics:
        return 'statistics';
      case StatisticsType.statisticsEdit:
        return 'statistics/$intPathParam/edit';
      case StatisticsType.statisticsStore:
        return 'statistics/store';
      case StatisticsType.statisticsUpdate:
        return 'statistics/$intPathParam/update';
      case StatisticsType.statisticsDelete:
        return 'statistics/$intPathParam/delete';

    }
  }

  @override
  HttpMethod get method {
    switch (type) {
      case StatisticsType.statistics:
        return HttpMethod.GET;
      case StatisticsType.statisticsEdit:
        return HttpMethod.GET;
    // case TrainingType.getFood:
    //   return HttpMethod.GET;
    // case TrainingType.getCommonFood:
    //   return HttpMethod.POST;
      default:
        return HttpMethod.POST;
    }
  }
}
