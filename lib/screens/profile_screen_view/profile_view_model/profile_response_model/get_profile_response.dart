/// is_error : false
/// data : {"first_name":"shreyansh","last_name":"shah","country":"Haiti","position":"power_forward","team":"hawks","jersey_number":4,"gender":"male","instagram":"bill gates","image":"https://qbounce.api.appmatictech.com/storage/26/use-4.jpg"}

class GetProfileResponse {
  GetProfileResponse({
    bool? isError,
    Data? data,}){
    _isError = isError;
    _data = data;
  }

  GetProfileResponse.fromJson(dynamic json) {
    _isError = json['is_error'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _isError;
  Data? _data;
  GetProfileResponse copyWith({  bool? isError,
    Data? data,
  }) => GetProfileResponse(  isError: isError ?? _isError,
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

/// first_name : "shreyansh"
/// last_name : "shah"
/// country : "Haiti"
/// position : "power_forward"
/// team : "hawks"
/// jersey_number : 4
/// gender : "male"
/// instagram : "bill gates"
/// image : "https://qbounce.api.appmatictech.com/storage/26/use-4.jpg"

class Data {
  Data({
    String? firstName,
    String? lastName,
    String? country,
    String? position,
    String? team,
    num? jerseyNumber,
    String? gender,
    String? instagram,
    String? image,}){
    _firstName = firstName;
    _lastName = lastName;
    _country = country;
    _position = position;
    _team = team;
    _jerseyNumber = jerseyNumber;
    _gender = gender;
    _instagram = instagram;
    _image = image;
  }

  Data.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _country = json['country'];
    _position = json['position'];
    _team = json['team'];
    _jerseyNumber = json['jersey_number'];
    _gender = json['gender'];
    _instagram = json['instagram'];
    _image = json['image'];
  }
  String? _firstName;
  String? _lastName;
  String? _country;
  String? _position;
  String? _team;
  num? _jerseyNumber;
  String? _gender;
  String? _instagram;
  String? _image;
  Data copyWith({  String? firstName,
    String? lastName,
    String? country,
    String? position,
    String? team,
    num? jerseyNumber,
    String? gender,
    String? instagram,
    String? image,
  }) => Data(  firstName: firstName ?? _firstName,
    lastName: lastName ?? _lastName,
    country: country ?? _country,
    position: position ?? _position,
    team: team ?? _team,
    jerseyNumber: jerseyNumber ?? _jerseyNumber,
    gender: gender ?? _gender,
    instagram: instagram ?? _instagram,
    image: image ?? _image,
  );
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get country => _country;
  String? get position => _position;
  String? get team => _team;
  num? get jerseyNumber => _jerseyNumber;
  String? get gender => _gender;
  String? get instagram => _instagram;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['country'] = _country;
    map['position'] = _position;
    map['team'] = _team;
    map['jersey_number'] = _jerseyNumber;
    map['gender'] = _gender;
    map['instagram'] = _instagram;
    map['image'] = _image;
    return map;
  }

}