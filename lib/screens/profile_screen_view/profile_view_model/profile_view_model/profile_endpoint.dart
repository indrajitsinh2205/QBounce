

import 'dart:io';

import '../../../../app_services/app_preferences.dart';
import '../../../../app_services/common_Capital.dart';
import '../../../../network/base_api_configuration/api_end_point.dart';


enum ProfileType { getProfile,updateProfile,userDetails}

class ProfileApiEndpoint implements APIEndpoint {
  final ProfileType type;
  final Map<String, dynamic>? requestBody;
  final Map<String, dynamic>? requestParam;
  final List<String>? pathParam;
  final String? stringPathParam;
  final int? intPathParam;


  ProfileApiEndpoint(this.type, {this.requestBody, this.requestParam, this.pathParam,this.stringPathParam, this.intPathParam,});

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
    "x-session-token":GlobleValue.session.value ?? '',
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

      case ProfileType.getProfile:
        return 'user_info';
      case ProfileType.updateProfile:
        return 'user_info';
        case ProfileType.userDetails:
        return 'user-details';

    }
  }

  @override
  HttpMethod get method {
    switch (type) {
      case ProfileType.getProfile:
        return HttpMethod.GET;
      case ProfileType.updateProfile:
        return HttpMethod.POST;
      case ProfileType.userDetails:
        return HttpMethod.GET;

      default:
        return HttpMethod.POST;
    }
  }
}
