



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/screens/leaderboard_screen_view/leaderboard_bloc/leader_board_event.dart';
import 'package:q_bounce/screens/leaderboard_screen_view/leaderboard_bloc/leader_board_state.dart';

import '../leaderboard_view_model/leaderboard_view_model.dart';

class LeaderBoardBloc extends Bloc<LeaderBoardEvent, LeaderBoardState> {
  // Constructor
  LeaderBoardBloc() : super(LeaderBoardInitial()) {
    on<FetchLeaderBoard>(_onFetchLeaderBoard);
  }

  Future<void> _onFetchLeaderBoard(FetchLeaderBoard event, Emitter<LeaderBoardState> emit) async {
    emit(LeaderBoardLoading());
    try {
      final response = await LeaderBoardViewModel().getLeaderBoard(event.query);
      print("responseVideo ${response}");
      if (response != null) {
        emit(LeaderBoardLoaded(response));
      } else {
        emit(LeaderBoardError('No data found'));
      }
    } catch (e) {
      emit(LeaderBoardError('An unexpected error occurred: $e'));
    }
  }

}
// TODO Implement this library.