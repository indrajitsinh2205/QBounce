// /// is_error : false
// /// data : {"unlocked":[{"id":1,"title":"TRIPLE THREAT","category_name":"beginner","description":"Get introduced to basketball! Learn about the court, the basic rules, and positions that every player should know to start playing.","video_url":"https://qbounce-production.s3.us-east-2.amazonaws.com/videos/VIDEO_1.mp4","xp":100,"created_at":"2025-01-08T07:21:25.000000Z","updated_at":"2025-01-08T07:21:25.000000Z","thumbnail_url":"https://qbounce-production.s3.us-east-2.amazonaws.com/videos/thumbnails/VIDEO_1.webp"},{"id":2,"title":"POUND","category_name":"beginner","description":"Learn the essential dribbling techniques, how to control the ball, and how to change direction with ease.","video_url":"https://qbounce-production.s3.us-east-2.amazonaws.com/videos/VIDEO_2.mp4","xp":100,"created_at":"2025-01-08T07:21:25.000000Z","updated_at":"2025-01-08T07:21:25.000000Z","thumbnail_url":"https://qbounce-production.s3.us-east-2.amazonaws.com/videos/thumbnails/VIDEO_2.webp"},{"id":3,"title":"CROSS","category_name":"beginner","description":"Learn the importance of footwork. This tutorial covers basic movements, including pivoting, shuffling, and proper stance.","video_url":"https://qbounce-production.s3.us-east-2.amazonaws.com/videos/VIDEO_3.mp4","xp":100,"created_at":"2025-01-08T07:21:25.000000Z","updated_at":"2025-01-08T07:21:25.000000Z","thumbnail_url":"https://qbounce-production.s3.us-east-2.amazonaws.com/videos/thumbnails/VIDEO_3.webp"}],"locked":[],"currentVideoId":3,"highestTrainingCount":1,"lastWatched":{"training_id":1,"latest_update":"2025-01-23 12:08:26"},"category":"beginner"}
//
// class TrainingResponse {
//   TrainingResponse({
//       bool? isError,
//       Data? data,}){
//     _isError = isError;
//     _data = data;
// }
//
//   TrainingResponse.fromJson(dynamic json) {
//     _isError = json['is_error'];
//     _data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//   bool? _isError;
//   Data? _data;
// TrainingResponse copyWith({  bool? isError,
//   Data? data,
// }) => TrainingResponse(  isError: isError ?? _isError,
//   data: data ?? _data,
// );
//   bool? get isError => _isError;
//   Data? get data => _data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['is_error'] = _isError;
//     if (_data != null) {
//       map['data'] = _data?.toJson();
//     }
//     return map;
//   }
//
// }
//
// /// unlocked : [{"id":1,"title":"TRIPLE THREAT","category_name":"beginner","description":"Get introduced to basketball! Learn about the court, the basic rules, and positions that every player should know to start playing.","video_url":"https://qbounce-production.s3.us-east-2.amazonaws.com/videos/VIDEO_1.mp4","xp":100,"created_at":"2025-01-08T07:21:25.000000Z","updated_at":"2025-01-08T07:21:25.000000Z","thumbnail_url":"https://qbounce-production.s3.us-east-2.amazonaws.com/videos/thumbnails/VIDEO_1.webp"},{"id":2,"title":"POUND","category_name":"beginner","description":"Learn the essential dribbling techniques, how to control the ball, and how to change direction with ease.","video_url":"https://qbounce-production.s3.us-east-2.amazonaws.com/videos/VIDEO_2.mp4","xp":100,"created_at":"2025-01-08T07:21:25.000000Z","updated_at":"2025-01-08T07:21:25.000000Z","thumbnail_url":"https://qbounce-production.s3.us-east-2.amazonaws.com/videos/thumbnails/VIDEO_2.webp"},{"id":3,"title":"CROSS","category_name":"beginner","description":"Learn the importance of footwork. This tutorial covers basic movements, including pivoting, shuffling, and proper stance.","video_url":"https://qbounce-production.s3.us-east-2.amazonaws.com/videos/VIDEO_3.mp4","xp":100,"created_at":"2025-01-08T07:21:25.000000Z","updated_at":"2025-01-08T07:21:25.000000Z","thumbnail_url":"https://qbounce-production.s3.us-east-2.amazonaws.com/videos/thumbnails/VIDEO_3.webp"}]
// /// locked : []
// /// currentVideoId : 3
// /// highestTrainingCount : 1
// /// lastWatched : {"training_id":1,"latest_update":"2025-01-23 12:08:26"}
// /// category : "beginner"
//
// class Data {
//   Data({
//       List<Unlocked>? unlocked,
//       List<dynamic>? locked,
//       num? currentVideoId,
//       num? highestTrainingCount,
//       LastWatched? lastWatched,
//       String? category,}){
//     _unlocked = unlocked;
//     _locked = locked;
//     _currentVideoId = currentVideoId;
//     _highestTrainingCount = highestTrainingCount;
//     _lastWatched = lastWatched;
//     _category = category;
// }
//
//   Data.fromJson(dynamic json) {
//     if (json['unlocked'] != null) {
//       _unlocked = [];
//       json['unlocked'].forEach((v) {
//         _unlocked?.add(Unlocked.fromJson(v));
//       });
//     }
//     if (json['locked'] != null) {
//       _locked = [];
//       json['locked'].forEach((v) {
//         _locked?.add(Dynamic.fromJson(v));
//       });
//     }
//     _currentVideoId = json['currentVideoId'];
//     _highestTrainingCount = json['highestTrainingCount'];
//     _lastWatched = json['lastWatched'] != null ? LastWatched.fromJson(json['lastWatched']) : null;
//     _category = json['category'];
//   }
//   List<Unlocked>? _unlocked;
//   List<dynamic>? _locked;
//   num? _currentVideoId;
//   num? _highestTrainingCount;
//   LastWatched? _lastWatched;
//   String? _category;
// Data copyWith({  List<Unlocked>? unlocked,
//   List<dynamic>? locked,
//   num? currentVideoId,
//   num? highestTrainingCount,
//   LastWatched? lastWatched,
//   String? category,
// }) => Data(  unlocked: unlocked ?? _unlocked,
//   locked: locked ?? _locked,
//   currentVideoId: currentVideoId ?? _currentVideoId,
//   highestTrainingCount: highestTrainingCount ?? _highestTrainingCount,
//   lastWatched: lastWatched ?? _lastWatched,
//   category: category ?? _category,
// );
//   List<Unlocked>? get unlocked => _unlocked;
//   List<dynamic>? get locked => _locked;
//   num? get currentVideoId => _currentVideoId;
//   num? get highestTrainingCount => _highestTrainingCount;
//   LastWatched? get lastWatched => _lastWatched;
//   String? get category => _category;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_unlocked != null) {
//       map['unlocked'] = _unlocked?.map((v) => v.toJson()).toList();
//     }
//     if (_locked != null) {
//       map['locked'] = _locked?.map((v) => v.toJson()).toList();
//     }
//     map['currentVideoId'] = _currentVideoId;
//     map['highestTrainingCount'] = _highestTrainingCount;
//     if (_lastWatched != null) {
//       map['lastWatched'] = _lastWatched?.toJson();
//     }
//     map['category'] = _category;
//     return map;
//   }
//
// }
//
// /// training_id : 1
// /// latest_update : "2025-01-23 12:08:26"
//
// class LastWatched {
//   LastWatched({
//       num? trainingId,
//       String? latestUpdate,}){
//     _trainingId = trainingId;
//     _latestUpdate = latestUpdate;
// }
//
//   LastWatched.fromJson(dynamic json) {
//     _trainingId = json['training_id'];
//     _latestUpdate = json['latest_update'];
//   }
//   num? _trainingId;
//   String? _latestUpdate;
// LastWatched copyWith({  num? trainingId,
//   String? latestUpdate,
// }) => LastWatched(  trainingId: trainingId ?? _trainingId,
//   latestUpdate: latestUpdate ?? _latestUpdate,
// );
//   num? get trainingId => _trainingId;
//   String? get latestUpdate => _latestUpdate;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['training_id'] = _trainingId;
//     map['latest_update'] = _latestUpdate;
//     return map;
//   }
//
// }
//
// /// id : 1
// /// title : "TRIPLE THREAT"
// /// category_name : "beginner"
// /// description : "Get introduced to basketball! Learn about the court, the basic rules, and positions that every player should know to start playing."
// /// video_url : "https://qbounce-production.s3.us-east-2.amazonaws.com/videos/VIDEO_1.mp4"
// /// xp : 100
// /// created_at : "2025-01-08T07:21:25.000000Z"
// /// updated_at : "2025-01-08T07:21:25.000000Z"
// /// thumbnail_url : "https://qbounce-production.s3.us-east-2.amazonaws.com/videos/thumbnails/VIDEO_1.webp"
//
// class Unlocked {
//   Unlocked({
//       num? id,
//       String? title,
//       String? categoryName,
//       String? description,
//       String? videoUrl,
//       num? xp,
//       String? createdAt,
//       String? updatedAt,
//       String? thumbnailUrl,}){
//     _id = id;
//     _title = title;
//     _categoryName = categoryName;
//     _description = description;
//     _videoUrl = videoUrl;
//     _xp = xp;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
//     _thumbnailUrl = thumbnailUrl;
// }
//
//   Unlocked.fromJson(dynamic json) {
//     _id = json['id'];
//     _title = json['title'];
//     _categoryName = json['category_name'];
//     _description = json['description'];
//     _videoUrl = json['video_url'];
//     _xp = json['xp'];
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//     _thumbnailUrl = json['thumbnail_url'];
//   }
//   num? _id;
//   String? _title;
//   String? _categoryName;
//   String? _description;
//   String? _videoUrl;
//   num? _xp;
//   String? _createdAt;
//   String? _updatedAt;
//   String? _thumbnailUrl;
// Unlocked copyWith({  num? id,
//   String? title,
//   String? categoryName,
//   String? description,
//   String? videoUrl,
//   num? xp,
//   String? createdAt,
//   String? updatedAt,
//   String? thumbnailUrl,
// }) => Unlocked(  id: id ?? _id,
//   title: title ?? _title,
//   categoryName: categoryName ?? _categoryName,
//   description: description ?? _description,
//   videoUrl: videoUrl ?? _videoUrl,
//   xp: xp ?? _xp,
//   createdAt: createdAt ?? _createdAt,
//   updatedAt: updatedAt ?? _updatedAt,
//   thumbnailUrl: thumbnailUrl ?? _thumbnailUrl,
// );
//   num? get id => _id;
//   String? get title => _title;
//   String? get categoryName => _categoryName;
//   String? get description => _description;
//   String? get videoUrl => _videoUrl;
//   num? get xp => _xp;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//   String? get thumbnailUrl => _thumbnailUrl;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['title'] = _title;
//     map['category_name'] = _categoryName;
//     map['description'] = _description;
//     map['video_url'] = _videoUrl;
//     map['xp'] = _xp;
//     map['created_at'] = _createdAt;
//     map['updated_at'] = _updatedAt;
//     map['thumbnail_url'] = _thumbnailUrl;
//     return map;
//   }
//
// }
class TrainingResponse {
  bool? isError;
  Data? data;

  TrainingResponse({
    this.isError,
    this.data,
  });

  factory TrainingResponse.fromJson(Map<String, dynamic> json) {
    return TrainingResponse(
      isError: json['is_error'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  List<Unlocked> unlocked;
  List<Locked> locked;
  int currentVideoId;
  int highestTrainingCount;
  LastWatched lastWatched;
  String category;

  Data({
    required this.unlocked,
    required this.locked,
    required this.currentVideoId,
    required this.highestTrainingCount,
    required this.lastWatched,
    required this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      unlocked: (json['unlocked'] as List)
          .map((item) => Unlocked.fromJson(item))
          .toList(),
      locked: (json['locked'] as List)
          .map((item) => Locked.fromJson(item))
          .toList(),
      // locked: json['locked'] ?? [],
      currentVideoId: json['currentVideoId'],
      highestTrainingCount: json['highestTrainingCount'],
      lastWatched: LastWatched.fromJson(json['lastWatched']),
      category: json['category'],
    );
  }
}

class LastWatched {
  int trainingId;
  DateTime latestUpdate;

  LastWatched({
    required this.trainingId,
    required this.latestUpdate,
  });

  factory LastWatched.fromJson(Map<String, dynamic> json) {
    return LastWatched(
      trainingId: json['training_id'],
      latestUpdate: DateTime.parse(json['latest_update']),
    );
  }
}

class Unlocked {
  int id;
  String title;
  String categoryName;
  String description;
  String videoUrl;
  int xp;
  DateTime createdAt;
  DateTime updatedAt;
  String thumbnailUrl;

  Unlocked({
    required this.id,
    required this.title,
    required this.categoryName,
    required this.description,
    required this.videoUrl,
    required this.xp,
    required this.createdAt,
    required this.updatedAt,
    required this.thumbnailUrl,
  });

  factory Unlocked.fromJson(Map<String, dynamic> json) {
    return Unlocked(
      id: json['id'],
      title: json['title'],
      categoryName: json['category_name'],
      description: json['description'],
      videoUrl: json['video_url'],
      xp: json['xp'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      thumbnailUrl: json['thumbnail_url'],
    );
  }

}
class Locked {
  int id;
  String title;
  String description;

  Locked({
    required this.id,
    required this.title,
    required this.description,
  });
  factory Locked.fromJson(Map<String, dynamic> json) {
    return Locked(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}