import 'package:bloc/bloc.dart';
import 'package:q_bounce/screens/profile_screen_view/profile_singleton.dart';
import 'package:q_bounce/screens/training_screen_view/training_program_bloc/training_program_event.dart';
import 'package:q_bounce/screens/training_screen_view/training_program_bloc/training_program_state.dart';

import '../training_bloc/training_program_state.dart';
import '../training_view_model/training_video_view_model.dart';
import '../training_view_model/training_view_model.dart';

class TrainingProgramBloc
    extends Bloc<TrainingProgramEvent, TrainingProgramState> {
  // Constructor
  TrainingProgramBloc() : super(TrainingInitial()) {
    on<FetchTraining>(_onFetchTraining);
  }

  Future<void> _onFetchTraining(
      FetchTraining event, Emitter<TrainingProgramState> emit) async {
    emit(TrainingLoading());
    try {
      var data = LevelModuleDataHandler.instance.trainingDataMap[event.query];
      if (data != null) {
        emit(TrainingLoaded(data));
      } else {
        final response = await TrainingViewModel().getTraining(event.query);
        print("response1 ii${response?.data}ii");

        if (response != null) {
          LevelModuleDataHandler.instance.trainingDataMap[event.query] =
              response;

          // fetchVideo(response.data.unlocked.first.id.toString());

          emit(TrainingLoaded(response));
        } else {
          emit(TrainingError('Something went Wrong'));
        }
      }
    } catch (e) {
      emit(TrainingError('An unexpected error occurred: $e'));
    }
  }

  void fetchVideo(String query) async {
    try {
      var data = LevelModuleDataHandler.instance.videoDataMap[query];
      if (data != null) {
        return;
      } else {
        final response = await TrainingVideoViewModel().getTrainingVideo(query);
        print("responseVideo ${response}");
        if (response != null) {
          LevelModuleDataHandler.instance.videoDataMap[query] = response;
          return;
        } else {}
      }
    } catch (e) {}
  }
}

