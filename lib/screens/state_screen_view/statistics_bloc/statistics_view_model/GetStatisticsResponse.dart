
class GetStatisticsResponse {
  GetStatisticsResponse({
    required this.isError,
    required this.data,
     this.currentPage,
     this.pageCount,
  });

  factory GetStatisticsResponse.fromJson(Map<String, dynamic> json) {
    return GetStatisticsResponse(
      isError: json['is_error'] ?? false,
      data: (json['data'] as List?)?.map((v) => StatisticsData.fromJson(v)).toList() ?? [],
      currentPage: json['current_page'] ?? 1,
      pageCount: json['page_count'] ?? 1,
    );
  }

  final bool isError;
  final List<StatisticsData> data;
  final int? currentPage;
  final int? pageCount;

  Map<String, dynamic> toJson() {
    return {
      'is_error': isError,
      'data': data.map((v) => v.toJson()).toList(),
      'current_page': currentPage,
      'page_count': pageCount,
    };
  }
}

class StatisticsData {
  StatisticsData({
    required this.id,
    required this.userId,
    required this.gameDate,
    required this.opponentTeam,
    required this.location,
    required this.pointsScored,
    required this.rebounds,
    required this.assists,
    required this.steals,
    required this.blockedShots,
  });

  factory StatisticsData.fromJson(Map<String, dynamic> json) {
    return StatisticsData(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      gameDate: json['game_date'] ?? "",
      opponentTeam: json['opponent_team'] ?? "Unknown",
      location: json['location'] ?? "Unknown",
      pointsScored: json['points_scored'] ?? 0,
      rebounds: json['rebounds'] ?? 0,
      assists: json['assists'] ?? 0,
      steals: json['steals'] ?? 0,
      blockedShots: json['blocked_shots'] ?? 0,
    );
  }

  final int id;
  final int userId;
  final String gameDate;
  final String opponentTeam;
  final String location;
  final int pointsScored;
  final int rebounds;
  final int assists;
  final int steals;
  final int blockedShots;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'game_date': gameDate,
      'opponent_team': opponentTeam,
      'location': location,
      'points_scored': pointsScored,
      'rebounds': rebounds,
      'assists': assists,
      'steals': steals,
      'blocked_shots': blockedShots,
    };
  }
}
