/// is_error : false
/// data : []
/// message : "User info updated."

class ContactUsResponse {
  ContactUsResponse({
    bool? isError,
    List<dynamic>? data,
    String? message,}){
    _isError = isError;
    _data = data;
    _message = message;
  }

  ContactUsResponse.fromJson(dynamic json) {
    _isError = json['is_error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add((v));
      });
    }
    _message = json['message'];
  }
  bool? _isError;
  List<dynamic>? _data;
  String? _message;
  ContactUsResponse copyWith({  bool? isError,
    List<dynamic>? data,
    String? message,
  }) => ContactUsResponse(  isError: isError ?? _isError,
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
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}