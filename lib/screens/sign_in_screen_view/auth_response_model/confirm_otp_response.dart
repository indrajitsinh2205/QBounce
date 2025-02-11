/// is_error : false
/// data : {"session_token":"7F0Bs7MFZZxq0w12LDhFvrd9TcQwEZKFVQ2y5R8135pEUpzvG5yF3eSycl6Gr2cgWsu5bgvQT78kKYYV1lDKl8odb6zveT3w2R6ZKIjKK4z19B4QKu1J4Bzkj61M8EgG","user":{"id":607,"name":null,"email":"indrajit@appmatictech.com"}}

class ConfirmOtpResponse {
  ConfirmOtpResponse({
    bool? isError,
    Data? data,}){
    _isError = isError;
    _data = data;
  }

  ConfirmOtpResponse.fromJson(dynamic json) {
    _isError = json['is_error'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _isError;
  Data? _data;
  ConfirmOtpResponse copyWith({  bool? isError,
    Data? data,
  }) => ConfirmOtpResponse(  isError: isError ?? _isError,
    data: data ?? _data,
  );
  bool? get isError => _isError;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_error'] = _isError;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// session_token : "7F0Bs7MFZZxq0w12LDhFvrd9TcQwEZKFVQ2y5R8135pEUpzvG5yF3eSycl6Gr2cgWsu5bgvQT78kKYYV1lDKl8odb6zveT3w2R6ZKIjKK4z19B4QKu1J4Bzkj61M8EgG"
/// user : {"id":607,"name":null,"email":"indrajit@appmatictech.com"}

class Data {
  Data({
    String? sessionToken,
    User? user,}){
    _sessionToken = sessionToken;
    _user = user;
  }

  Data.fromJson(dynamic json) {
    _sessionToken = json['session_token'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _sessionToken;
  User? _user;
  Data copyWith({  String? sessionToken,
    User? user,
  }) => Data(  sessionToken: sessionToken ?? _sessionToken,
    user: user ?? _user,
  );
  String? get sessionToken => _sessionToken;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['session_token'] = _sessionToken;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// id : 607
/// name : null
/// email : "indrajit@appmatictech.com"

class User {
  User({
    num? id,
    dynamic name,
    String? email,}){
    _id = id;
    _name = name;
    _email = email;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
  }
  num? _id;
  dynamic _name;
  String? _email;
  User copyWith({  num? id,
    dynamic name,
    String? email,
  }) => User(  id: id ?? _id,
    name: name ?? _name,
    email: email ?? _email,
  );
  num? get id => _id;
  dynamic get name => _name;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    return map;
  }

}