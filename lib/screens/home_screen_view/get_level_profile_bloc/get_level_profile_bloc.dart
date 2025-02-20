

import 'package:bloc/bloc.dart';
import 'package:q_bounce/screens/profile_screen_view/profile_singleton.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_event.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_state.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_view_model/statistics_view_model.dart';
import 'package:q_bounce/screens/training_screen_view/training_bloc/training_program_event.dart';
import 'package:q_bounce/screens/training_screen_view/training_bloc/training_program_state.dart';

import '../get_level_profile_view_model.dart';
import 'get_level_profile_event.dart';
import 'get_level_profile_state.dart';

class LevelProfileBloc extends Bloc<LevelProfileEvent, LevelProfileState> {
  // Constructor
  LevelProfileBloc() : super(LevelProfileInitial()) {
    on<FetchLevelProfile>(_onFetchstatistics);
  }

  Future<void> _onFetchstatistics(FetchLevelProfile event, Emitter<LevelProfileState> emit) async {
    emit(LevelProfileLoading());
    try {

      var fetchedData = LevelModuleDataHandler.instance.levelData;
      if (fetchedData != null){
        emit(LevelProfileLoaded(fetchedData));
      }else {
        final response = await GetLevelProfileViewModel().getLevelProfile();
        print("statisticsResponse1 ${response}");
        if (response != null) {
          LevelModuleDataHandler.instance.levelData = response;
          emit(LevelProfileLoaded(response));
        } else {
          emit(LevelProfileError('Something went Wrong'));
        }
      }
    } catch (e) {
      emit(LevelProfileError('An unexpected error occurred: $e'));
    }
  }

}
// TODO Implement this library.
