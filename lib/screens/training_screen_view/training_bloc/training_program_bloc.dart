

import 'package:bloc/bloc.dart';
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
      final response = await TrainingVideoViewModel().getTrainingVideo(event.query);
      print("responseVideo ${response}");
      if (response != null) {
        emit(TrainingVideoLoaded(response));
      } else {
        emit(TrainingVideoError('No data found'));
      }
    } catch (e) {
      emit(TrainingVideoError('An unexpected error occurred: $e'));
    }
  }

}
// TODO Implement this library.