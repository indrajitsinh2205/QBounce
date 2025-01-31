class PostStatisticsUpdateRequestRequestModel {
  final String opponentTeam;
  final String location;
  final String pointsScored;
  final String rebounds;
  final String assists;
  final String steals;
  final String blockedShots;
  final String gameDate;

  PostStatisticsUpdateRequestRequestModel({
    required this.opponentTeam,
    required this.location,
    required this.pointsScored,
    required this.rebounds,
    required this.assists,
    required this.steals,
    required this.blockedShots,
    required this.gameDate,
  });

  // Factory method to create an instance from a Map<String, dynamic>
  factory PostStatisticsUpdateRequestRequestModel.fromJson(Map<String, dynamic> json) {
    return PostStatisticsUpdateRequestRequestModel(
      opponentTeam: json['opponent_team'] ?? '',
      location: json['location'] ?? '',
      pointsScored: json['points_scored'] ?? 0,
      rebounds: json['rebounds'] ?? 0,
      assists: json['assists'] ?? 0,
      steals: json['steals'] ?? 0,
      blockedShots: json['blocked_shots'] ?? 0,
      gameDate: json['game_date'] ?? '',
    );
  }

  // Method to convert the model to a Map<String, dynamic> (JSON)
  Map<String, dynamic> toJson() {
    return {
      'opponent_team': opponentTeam,
      'location': location,
      'points_scored': pointsScored,
      'rebounds': rebounds,
      'assists': assists,
      'steals': steals,
      'blocked_shots': blockedShots,
      'game_date': gameDate,
    };
  }
}
