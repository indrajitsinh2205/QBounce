abstract class LeaderBoardEvent {}

class FetchLeaderBoard extends LeaderBoardEvent {
  final String query;

  FetchLeaderBoard(this.query);
}


