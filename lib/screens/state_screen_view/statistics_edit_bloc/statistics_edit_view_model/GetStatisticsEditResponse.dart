/// is_error : false
/// data : {"statistics":{"id":10,"game_date":"2025-01-23T00:00:00.000000Z","opponent_team":"Pakistan","location":"dfs","points_scored":1,"rebounds":1,"assists":3,"steals":4,"blocked_shots":5}}

class GetStatisticsEditResponse {
  GetStatisticsEditResponse({
      bool? isError, 
      Data? data,}){
    _isError = isError;
    _data = data;
}

  GetStatisticsEditResponse.fromJson(dynamic json) {
    _isError = json['is_error'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _isError;
  Data? _data;
GetStatisticsEditResponse copyWith({  bool? isError,
  Data? data,
}) => GetStatisticsEditResponse(  isError: isError ?? _isError,
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

/// statistics : {"id":10,"game_date":"2025-01-23T00:00:00.000000Z","opponent_team":"Pakistan","location":"dfs","points_scored":1,"rebounds":1,"assists":3,"steals":4,"blocked_shots":5}

class Data {
  Data({
      Statistics? statistics,}){
    _statistics = statistics;
}

  Data.fromJson(dynamic json) {
    _statistics = json['statistics'] != null ? Statistics.fromJson(json['statistics']) : null;
  }
  Statistics? _statistics;
Data copyWith({  Statistics? statistics,
}) => Data(  statistics: statistics ?? _statistics,
);
  Statistics? get statistics => _statistics;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_statistics != null) {
      map['statistics'] = _statistics?.toJson();
    }
    return map;
  }

}

/// id : 10
/// game_date : "2025-01-23T00:00:00.000000Z"
/// opponent_team : "Pakistan"
/// location : "dfs"
/// points_scored : 1
/// rebounds : 1
/// assists : 3
/// steals : 4
/// blocked_shots : 5

class Statistics {
  Statistics({
      num? id, 
      String? gameDate, 
      String? opponentTeam, 
      String? location, 
      num? pointsScored, 
      num? rebounds, 
      num? assists, 
      num? steals, 
      num? blockedShots,}){
    _id = id;
    _gameDate = gameDate;
    _opponentTeam = opponentTeam;
    _location = location;
    _pointsScored = pointsScored;
    _rebounds = rebounds;
    _assists = assists;
    _steals = steals;
    _blockedShots = blockedShots;
}

  Statistics.fromJson(dynamic json) {
    _id = json['id'];
    _gameDate = json['game_date'];
    _opponentTeam = json['opponent_team'];
    _location = json['location'];
    _pointsScored = json['points_scored'];
    _rebounds = json['rebounds'];
    _assists = json['assists'];
    _steals = json['steals'];
    _blockedShots = json['blocked_shots'];
  }
  num? _id;
  String? _gameDate;
  String? _opponentTeam;
  String? _location;
  num? _pointsScored;
  num? _rebounds;
  num? _assists;
  num? _steals;
  num? _blockedShots;
Statistics copyWith({  num? id,
  String? gameDate,
  String? opponentTeam,
  String? location,
  num? pointsScored,
  num? rebounds,
  num? assists,
  num? steals,
  num? blockedShots,
}) => Statistics(  id: id ?? _id,
  gameDate: gameDate ?? _gameDate,
  opponentTeam: opponentTeam ?? _opponentTeam,
  location: location ?? _location,
  pointsScored: pointsScored ?? _pointsScored,
  rebounds: rebounds ?? _rebounds,
  assists: assists ?? _assists,
  steals: steals ?? _steals,
  blockedShots: blockedShots ?? _blockedShots,
);
  num? get id => _id;
  String? get gameDate => _gameDate;
  String? get opponentTeam => _opponentTeam;
  String? get location => _location;
  num? get pointsScored => _pointsScored;
  num? get rebounds => _rebounds;
  num? get assists => _assists;
  num? get steals => _steals;
  num? get blockedShots => _blockedShots;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['game_date'] = _gameDate;
    map['opponent_team'] = _opponentTeam;
    map['location'] = _location;
    map['points_scored'] = _pointsScored;
    map['rebounds'] = _rebounds;
    map['assists'] = _assists;
    map['steals'] = _steals;
    map['blocked_shots'] = _blockedShots;
    return map;
  }

}