
enum HttpMethod { GET, POST, DELETE, PUT,  }


abstract class APIEndpoint {
  String get baseURL;
  String get versionURL;
  Uri get finalURL;
  String get path;
  HttpMethod get method;
  Map<String, dynamic>? get body;
  Map<String, dynamic>? get queryParam;
  List<String>? get pathParam;
  Map<String, String> get headers;
}
