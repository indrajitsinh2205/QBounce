

import 'package:bloc/bloc.dart';
import 'package:q_bounce/screens/profile_screen_view/profile_singleton.dart';
import 'package:q_bounce/screens/training_screen_view/training_bloc/training_program_event.dart';
import 'package:q_bounce/screens/training_screen_view/training_bloc/training_program_state.dart';
import '../training_view_model/training_video_view_model.dart';

class TrainingVideoBloc extends Bloc<TrainingVideoEvent, TrainingVideoState> {
  // Constructor
  TrainingVideoBloc() : super(TrainingVideoInitial()) {
    on<FetchTrainingVideo>(_onFetchTrainingVideo);
  }

  Future<void> _onFetchTrainingVideo(FetchTrainingVideo event, Emitter<TrainingVideoState> emit) async {
    emit(TrainingVideoLoading());
    try {
      var data = LevelModuleDataHandler.instance.videoDataMap[event.query];
      if(data !=null){
        emit(TrainingVideoLoaded(data));
      }
      else {
        final response = await TrainingVideoViewModel().getTrainingVideo(
            event.query);
        print("responseVideo ${response}");
        if (response != null) {
          LevelModuleDataHandler.instance.videoDataMap[event.query] = response;
          emit(TrainingVideoLoaded(response));
        } else {
          emit(TrainingVideoError('Something went Wrong'));
        }
      }
    } catch (e) {
      emit(TrainingVideoError('An unexpected error occurred: $e'));
    }
  }

}
// TODO Implement this library.
