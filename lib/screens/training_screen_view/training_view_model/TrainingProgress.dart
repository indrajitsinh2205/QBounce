/// is_error : false
/// data : {"user_id":75,"training_id":"3","reward_points":100,"updated_at":"2025-01-29T07:46:51.000000Z","created_at":"2025-01-29T07:46:51.000000Z","id":35}

class TrainingProgressResponse {
  TrainingProgressResponse({
      bool? isError, 
      Data? data,}){
    _isError = isError;
    _data = data;
}

  TrainingProgressResponse.fromJson(dynamic json) {
    _isError = json['is_error'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _isError;
  Data? _data;
TrainingProgressResponse copyWith({  bool? isError,
  Data? data,
}) => TrainingProgressResponse(  isError: isError ?? _isError,
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

/// user_id : 75
/// training_id : "3"
/// reward_points : 100
/// updated_at : "2025-01-29T07:46:51.000000Z"
/// created_at : "2025-01-29T07:46:51.000000Z"
/// id : 35

class Data {
  Data({
      num? userId, 
      String? trainingId, 
      num? rewardPoints, 
      String? updatedAt, 
      String? createdAt, 
      num? id,}){
    _userId = userId;
    _trainingId = trainingId;
    _rewardPoints = rewardPoints;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _trainingId = json['training_id'];
    _rewardPoints = json['reward_points'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  num? _userId;
  String? _trainingId;
  num? _rewardPoints;
  String? _updatedAt;
  String? _createdAt;
  num? _id;
Data copyWith({  num? userId,
  String? trainingId,
  num? rewardPoints,
  String? updatedAt,
  String? createdAt,
  num? id,
}) => Data(  userId: userId ?? _userId,
  trainingId: trainingId ?? _trainingId,
  rewardPoints: rewardPoints ?? _rewardPoints,
  updatedAt: updatedAt ?? _updatedAt,
  createdAt: createdAt ?? _createdAt,
  id: id ?? _id,
);
  num? get userId => _userId;
  String? get trainingId => _trainingId;
  num? get rewardPoints => _rewardPoints;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['training_id'] = _trainingId;
    map['reward_points'] = _rewardPoints;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }

}