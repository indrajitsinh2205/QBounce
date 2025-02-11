/// is_error : false
/// data : {"id":607,"first_name":"John","last_name":"Doe","country":"Haiti","average_points_scored":null,"average_rebounds":null,"average_assists":null,"average_steals":null,"average_blocked_shots":null,"jersey_number":10,"stars":0,"image":"https://qbounce.api.appmatictech.com/storage/29/Screenshot_2025-02-08-20-02-32-325_lockscreen_out.jpeg"}

class GetLevelProfileResponse {
  GetLevelProfileResponse({
    bool? isError,
    LevelData? data,}){
    _isError = isError;
    _data = data;
  }

  GetLevelProfileResponse.fromJson(dynamic json) {
    _isError = json['is_error'];
    _data = json['data'] != null ? LevelData.fromJson(json['data']) : null;
  }
  bool? _isError;
  LevelData? _data;
  GetLevelProfileResponse copyWith({  bool? isError,
    LevelData? data,
  }) => GetLevelProfileResponse(  isError: isError ?? _isError,
    data: data ?? _data,
  );
  bool? get isError => _isError;
  LevelData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_error'] = _isError;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 607
/// first_name : "John"
/// last_name : "Doe"
/// country : "Haiti"
/// average_points_scored : null
/// average_rebounds : null
/// average_assists : null
/// average_steals : null
/// average_blocked_shots : null
/// jersey_number : 10
/// stars : 0
/// image : "https://qbounce.api.appmatictech.com/storage/29/Screenshot_2025-02-08-20-02-32-325_lockscreen_out.jpeg"

class LevelData {
  LevelData({
    num? id,
    String? firstName,
    String? lastName,
    String? country,
    dynamic averagePointsScored,
    dynamic averageRebounds,
    dynamic averageAssists,
    dynamic averageSteals,
    dynamic averageBlockedShots,
    num? jerseyNumber,
    num? stars,
    String? image,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _country = country;
    _averagePointsScored = averagePointsScored;
    _averageRebounds = averageRebounds;
    _averageAssists = averageAssists;
    _averageSteals = averageSteals;
    _averageBlockedShots = averageBlockedShots;
    _jerseyNumber = jerseyNumber;
    _stars = stars;
    _image = image;
  }

  LevelData.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _country = json['country'];
    _averagePointsScored = json['average_points_scored'];
    _averageRebounds = json['average_rebounds'];
    _averageAssists = json['average_assists'];
    _averageSteals = json['average_steals'];
    _averageBlockedShots = json['average_blocked_shots'];
    _jerseyNumber = json['jersey_number'];
    _stars = json['stars'];
    _image = json['image'];
  }
  num? _id;
  String? _firstName;
  String? _lastName;
  String? _country;
  dynamic _averagePointsScored;
  dynamic _averageRebounds;
  dynamic _averageAssists;
  dynamic _averageSteals;
  dynamic _averageBlockedShots;
  num? _jerseyNumber;
  num? _stars;
  String? _image;
  LevelData copyWith({  num? id,
    String? firstName,
    String? lastName,
    String? country,
    dynamic averagePointsScored,
    dynamic averageRebounds,
    dynamic averageAssists,
    dynamic averageSteals,
    dynamic averageBlockedShots,
    num? jerseyNumber,
    num? stars,
    String? image,
  }) => LevelData(  id: id ?? _id,
    firstName: firstName ?? _firstName,
    lastName: lastName ?? _lastName,
    country: country ?? _country,
    averagePointsScored: averagePointsScored ?? _averagePointsScored,
    averageRebounds: averageRebounds ?? _averageRebounds,
    averageAssists: averageAssists ?? _averageAssists,
    averageSteals: averageSteals ?? _averageSteals,
    averageBlockedShots: averageBlockedShots ?? _averageBlockedShots,
    jerseyNumber: jerseyNumber ?? _jerseyNumber,
    stars: stars ?? _stars,
    image: image ?? _image,
  );
  num? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get country => _country;
  dynamic get averagePointsScored => _averagePointsScored;
  dynamic get averageRebounds => _averageRebounds;
  dynamic get averageAssists => _averageAssists;
  dynamic get averageSteals => _averageSteals;
  dynamic get averageBlockedShots => _averageBlockedShots;
  num? get jerseyNumber => _jerseyNumber;
  num? get stars => _stars;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['country'] = _country;
    map['average_points_scored'] = _averagePointsScored;
    map['average_rebounds'] = _averageRebounds;
    map['average_assists'] = _averageAssists;
    map['average_steals'] = _averageSteals;
    map['average_blocked_shots'] = _averageBlockedShots;
    map['jersey_number'] = _jerseyNumber;
    map['stars'] = _stars;
    map['image'] = _image;
    return map;
  }

}