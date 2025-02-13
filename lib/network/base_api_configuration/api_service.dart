import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_end_point.dart';

class ApiService {
  Future<http.Response> callApi(APIEndpoint endpoint) async {
    var uri = endpoint.finalURL;
    final headers = endpoint.headers;
    final body = endpoint.body != null ? json.encode(endpoint.body) : null;

    if (endpoint.queryParam != null) {
      uri = uri.replace(queryParameters: endpoint.queryParam);
    }
    print("URI : $uri");
    print("Body : $body");
    print("Header : $headers");

    late http.Response response;
    switch (endpoint.method) {
      case HttpMethod.POST:
        response = await http.post(uri, headers: headers, body: body);
        break;
      case HttpMethod.GET:
        response = await http.get(uri, headers: headers);
        break;
      case HttpMethod.PUT:
        response = await http.put(uri, headers: headers, body: body);
        break;
      case HttpMethod.DELETE:
        response = await http.delete(uri, headers: headers, body: body);
        break;
    }
    return response;
  }
}

