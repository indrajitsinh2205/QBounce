

import 'dart:io';

import '../../../app_services/app_preferences.dart';
import '../../../network/base_api_configuration/api_end_point.dart';

enum AuthType { sendOtp,getOtp,signOut}

class AuthApiEndpoint implements APIEndpoint {
String? sessionToken ;

  final AuthType type;
  final Map<String, dynamic>? requestBody;
  final Map<String, dynamic>? requestParam;
  final List<String>? pathParam;
  final String? stringPathParam;
final int? intPathParam;


AuthApiEndpoint(this.type, {this.requestBody, this.requestParam, this.pathParam,this.stringPathParam, this.intPathParam,});
Future<void> initialize() async {
  sessionToken = await AppPreferences().getToken();
  if (sessionToken == null) {
    throw Exception('No session token found');
  }
}
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
    "x-session-token":sessionToken ?? '',
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
      // case AuthType.searchFood:
      //   return  requestParam != null ? 'search/instant/?$requestParam' : 'search/instant';
      // case AuthType.getFood:
      //   return pathParam != null ? 'search/item/?$pathParam' : 'search/item';
        case AuthType.sendOtp:
        return 'send-otp';
      case AuthType.getOtp:
        return 'confirm-otp';
      case AuthType.signOut:
        return 'signout';

    }
  }

  @override
  HttpMethod get method {
    switch (type) {
      case AuthType.sendOtp:
        return HttpMethod.POST;
      case AuthType.getOtp:
        return HttpMethod.POST;
      // case AuthType.getFood:
      //   return HttpMethod.GET;
      // case AuthType.getCommonFood:
      //   return HttpMethod.POST;
      default:
        return HttpMethod.POST;
    }
  }
}
