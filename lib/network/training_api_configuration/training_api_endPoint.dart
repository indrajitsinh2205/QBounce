import 'dart:io';

import '../../app_services/app_preferences.dart';
import '../../app_services/common_Capital.dart';
import '../../network/base_api_configuration/api_end_point.dart';


enum TrainingType { beginner,training_video,trainingProgress,profile}

class TrainingApiEndpoint implements APIEndpoint {
  final TrainingType type;
  final Map<String, dynamic>? requestBody;
  final Map<String, dynamic>? requestParam;
  final List<String>? pathParam;
  final String? stringPathParam;

  TrainingApiEndpoint(this.type, {this.requestBody, this.requestParam, this.pathParam,this.stringPathParam});

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
    "x-session-token":GlobleValue.session.value?? '',
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
        case TrainingType.beginner:
        return 'trainingPrograms/$stringPathParam';
      case TrainingType.training_video:
        return 'training_video/$stringPathParam';
      case TrainingType.trainingProgress:
        return 'user_training_progress';
      case TrainingType.profile:
        return 'profile';

    }
  }

  @override
  HttpMethod get method {
    switch (type) {
      case TrainingType.beginner:
        return HttpMethod.GET;
      case TrainingType.training_video:
        return HttpMethod.GET;
      case TrainingType.profile:
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
