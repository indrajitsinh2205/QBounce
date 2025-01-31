class LeaderBoardResponse {
  LeaderBoardResponse({
    required bool isError,
    required Data data,
  })  : _isError = isError,
        _data = data;

  factory LeaderBoardResponse.fromJson(Map<String, dynamic> json) {
    return LeaderBoardResponse(
      isError: json['is_error'] ?? false,
      data: Data.fromJson(json['data'] ?? {}),
    );
  }

  final bool _isError;
  final Data _data;

  bool get isError => _isError;
  Data get data => _data;

  Map<String, dynamic> toJson() {
    return {
      'is_error': _isError,
      'data': _data.toJson(),
    };
  }
}

class Data {
  Data({
    required List<Leaders> leaders,
    required User user,
  })  : _leaders = leaders,
        _user = user;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      leaders: (json['leaders'] as List<dynamic>?)
          ?.map((e) => Leaders.fromJson(e))
          .toList() ??
          [], // Ensure empty list if null
      user: User.fromJson(json['user'] ?? {}),
    );
  }

  final List<Leaders> _leaders;
  final User _user;

  List<Leaders> get leaders => _leaders;
  User get user => _user;

  Map<String, dynamic> toJson() {
    return {
      'leaders': _leaders.map((e) => e.toJson()).toList(),
      'user': _user.toJson(),
    };
  }
}

class Leaders {
  Leaders({
    required int userId,
    required int totalRewardPoints,
    required String latestUpdate,
    required User user,
  })  : _userId = userId,
        _totalRewardPoints = totalRewardPoints,
        _latestUpdate = latestUpdate,
        _user = user;

  factory Leaders.fromJson(Map<String, dynamic> json) {
    return Leaders(
      userId: json['user_id'] ?? 0,
      totalRewardPoints: json['total_reward_points'] ?? 0,
      latestUpdate: json['latest_update'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }

  final int _userId;
  final int _totalRewardPoints;
  final String _latestUpdate;
  final User _user;

  int get userId => _userId;
  int get totalRewardPoints => _totalRewardPoints;
  String get latestUpdate => _latestUpdate;
  User get user => _user;

  Map<String, dynamic> toJson() {
    return {
      'user_id': _userId,
      'total_reward_points': _totalRewardPoints,
      'latest_update': _latestUpdate,
      'user': _user.toJson(),
    };
  }
}

class User {
  User({
    required int id,
    required String firstName,
    required String lastName,
    required String country,
    required String email,
    required String imageUrl,
    required List<Media> media,
  })  : _id = id,
        _firstName = firstName,
        _lastName = lastName,
        _country = country,
        _email = email,
        _imageUrl = imageUrl,
        _media = media;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      country: json['country'] ?? '',
      email: json['email'] ?? '',
      imageUrl: json['image_url'] ?? '',
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => Media.fromJson(e))
          .toList() ??
          [], // Default to an empty list
    );
  }

  final int _id;
  final String _firstName;
  final String _lastName;
  final String _country;
  final String _email;
  final String _imageUrl;
  final List<Media> _media;

  int get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get country => _country;
  String get email => _email;
  String get imageUrl => _imageUrl;
  List<Media> get media => _media;

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'first_name': _firstName,
      'last_name': _lastName,
      'country': _country,
      'email': _email,
      'image_url': _imageUrl,
      'media': _media.map((e) => e.toJson()).toList(),
    };
  }
}

class Media {
  Media({
    required int id,
    required String fileName,
    required String originalUrl,

  })  : _id = id,
        _fileName = fileName,
        _originalUrl = originalUrl;

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'] ?? 0,
      fileName: json['file_name'] ?? '',
        originalUrl: json['original_url']??''
    );
  }

  final int _id;
  final String _fileName;
  final String _originalUrl;

  int get id => _id;
  String get fileName => _fileName;
  String get originalUrl => _originalUrl;

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'file_name': _fileName,
      'original_url':_originalUrl
    };
  }
}
