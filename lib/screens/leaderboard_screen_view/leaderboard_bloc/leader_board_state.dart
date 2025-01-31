

import '../leaderboard_view_model/LeaderBoardResponse.dart';

abstract class LeaderBoardState {}

class LeaderBoardInitial extends LeaderBoardState {}

class LeaderBoardLoading extends LeaderBoardState {}

class LeaderBoardLoaded extends LeaderBoardState {
  final LeaderBoardResponse leaderBoardResponse;

  LeaderBoardLoaded(this.leaderBoardResponse);
}

class LeaderBoardError extends LeaderBoardState {
  final String errorMessage;

  LeaderBoardError(this.errorMessage);
}
