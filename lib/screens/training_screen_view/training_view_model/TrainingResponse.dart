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
  List<Unlocked>? unlocked;
  List<Locked>? locked;
  int? currentVideoId;
  int? highestTrainingCount;
  LastWatched? lastWatched;
  String? category;

  Data({
    this.unlocked,
    this.locked,
    this.currentVideoId,
    this.highestTrainingCount,
    this.lastWatched,
    this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      unlocked: (json['unlocked'] as List?)?.map((item) => Unlocked.fromJson(item)).toList(),
      locked: (json['locked'] as List?)?.map((item) => Locked.fromJson(item)).toList(),
      currentVideoId: json['currentVideoId'],
      highestTrainingCount: json['highestTrainingCount'],
      lastWatched: json['lastWatched'] != null ? LastWatched.fromJson(json['lastWatched']) : null,
      category: json['category'],
    );
  }
}

class LastWatched {
  int? trainingId;
  DateTime? latestUpdate;

  LastWatched({
    this.trainingId,
    this.latestUpdate,
  });

  factory LastWatched.fromJson(Map<String, dynamic> json) {
    return LastWatched(
      trainingId: json['training_id'],
      latestUpdate: json['latest_update'] != null ? DateTime.parse(json['latest_update']) : null,
    );
  }
}

class Unlocked {
  int? id;
  String? title;
  String? categoryName;
  String? description;
  String? videoUrl;
  int? xp;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? thumbnailUrl;

  Unlocked({
    this.id,
    this.title,
    this.categoryName,
    this.description,
    this.videoUrl,
    this.xp,
    this.createdAt,
    this.updatedAt,
    this.thumbnailUrl,
  });

  factory Unlocked.fromJson(Map<String, dynamic> json) {
    return Unlocked(
      id: json['id'],
      title: json['title'],
      categoryName: json['category_name'],
      description: json['description'],
      videoUrl: json['video_url'],
      xp: json['xp'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      thumbnailUrl: json['thumbnail_url'],
    );
  }
}

class Locked {
  int? id;
  String? title;
  String? description;

  Locked({
    this.id,
    this.title,
    this.description,
  });

  factory Locked.fromJson(Map<String, dynamic> json) {
    return Locked(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
