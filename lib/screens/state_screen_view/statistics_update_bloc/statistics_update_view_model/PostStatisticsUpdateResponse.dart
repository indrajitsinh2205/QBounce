class PostStatisticsUpdateResponse {
  PostStatisticsUpdateResponse({
    bool? isError,
    List<dynamic>? data,
    String? message,
  }) {
    _isError = isError;
    _data = data;
    _message = message;
  }

  PostStatisticsUpdateResponse.fromJson(dynamic json) {
    _isError = json['is_error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        // Assuming 'v' is dynamic or a specific type, no need to call Dynamic.fromJson.
        _data?.add(v); // Add the raw dynamic object directly
      });
    }
    _message = json['message'];
  }

  bool? _isError;
  List<dynamic>? _data;
  String? _message;

  PostStatisticsUpdateResponse copyWith({
    bool? isError,
    List<dynamic>? data,
    String? message,
  }) => PostStatisticsUpdateResponse(
    isError: isError ?? _isError,
    data: data ?? _data,
    message: message ?? _message,
  );

  bool? get isError => _isError;
  List<dynamic>? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_error'] = _isError;
    if (_data != null) {
      map['data'] = _data; // Directly map the dynamic data
    }
    map['message'] = _message;
    return map;
  }
}
