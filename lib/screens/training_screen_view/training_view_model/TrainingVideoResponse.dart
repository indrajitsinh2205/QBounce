/// is_error : false
/// data : {"id":1,"title":"TRIPLE THREAT","category_name":"beginner","description":"Get introduced to basketball! Learn about the court, the basic rules, and positions that every player should know to start playing.","video_url":"https://qbounce-production.s3.us-east-2.amazonaws.com/videos/VIDEO_1.mp4","xp":100,"created_at":"2025-01-08T07:21:25.000000Z","updated_at":"2025-01-08T07:21:25.000000Z","thumbnail_url":"https://qbounce-production.s3.us-east-2.amazonaws.com/videos/thumbnails/VIDEO_1.webp","count":3}

class TrainingVideoResponse {
  TrainingVideoResponse({
      bool? isError, 
      Data? data,}){
    _isError = isError;
    _data = data;
}

  TrainingVideoResponse.fromJson(dynamic json) {
    _isError = json['is_error'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _isError;
  Data? _data;
TrainingVideoResponse copyWith({  bool? isError,
  Data? data,
}) => TrainingVideoResponse(  isError: isError ?? _isError,
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

/// id : 1
/// title : "TRIPLE THREAT"
/// category_name : "beginner"
/// description : "Get introduced to basketball! Learn about the court, the basic rules, and positions that every player should know to start playing."
/// video_url : "https://qbounce-production.s3.us-east-2.amazonaws.com/videos/VIDEO_1.mp4"
/// xp : 100
/// created_at : "2025-01-08T07:21:25.000000Z"
/// updated_at : "2025-01-08T07:21:25.000000Z"
/// thumbnail_url : "https://qbounce-production.s3.us-east-2.amazonaws.com/videos/thumbnails/VIDEO_1.webp"
/// count : 3

class Data {
  Data({
      num? id, 
      String? title, 
      String? categoryName, 
      String? description, 
      String? videoUrl, 
      num? xp, 
      String? createdAt, 
      String? updatedAt, 
      String? thumbnailUrl, 
      num? count,}){
    _id = id;
    _title = title;
    _categoryName = categoryName;
    _description = description;
    _videoUrl = videoUrl;
    _xp = xp;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _thumbnailUrl = thumbnailUrl;
    _count = count;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _categoryName = json['category_name'];
    _description = json['description'];
    _videoUrl = json['video_url'];
    _xp = json['xp'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _thumbnailUrl = json['thumbnail_url'];
    _count = json['count'];
  }
  num? _id;
  String? _title;
  String? _categoryName;
  String? _description;
  String? _videoUrl;
  num? _xp;
  String? _createdAt;
  String? _updatedAt;
  String? _thumbnailUrl;
  num? _count;
Data copyWith({  num? id,
  String? title,
  String? categoryName,
  String? description,
  String? videoUrl,
  num? xp,
  String? createdAt,
  String? updatedAt,
  String? thumbnailUrl,
  num? count,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  categoryName: categoryName ?? _categoryName,
  description: description ?? _description,
  videoUrl: videoUrl ?? _videoUrl,
  xp: xp ?? _xp,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  thumbnailUrl: thumbnailUrl ?? _thumbnailUrl,
  count: count ?? _count,
);
  num? get id => _id;
  String? get title => _title;
  String? get categoryName => _categoryName;
  String? get description => _description;
  String? get videoUrl => _videoUrl;
  num? get xp => _xp;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get thumbnailUrl => _thumbnailUrl;
  num? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['category_name'] = _categoryName;
    map['description'] = _description;
    map['video_url'] = _videoUrl;
    map['xp'] = _xp;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['thumbnail_url'] = _thumbnailUrl;
    map['count'] = _count;
    return map;
  }

}