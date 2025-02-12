

import 'package:bloc/bloc.dart';
import 'package:q_bounce/screens/training_screen_view/training_program_bloc/training_program_event.dart';
import 'package:q_bounce/screens/training_screen_view/training_program_bloc/training_program_state.dart';
import 'package:q_bounce/screens/training_screen_view/training_progress_bloc/training_progress_event.dart';
import 'package:q_bounce/screens/training_screen_view/training_progress_bloc/training_progress_state.dart';

import '../training_view_model/training_progress_view_model.dart';
import '../training_view_model/training_view_model.dart';

class TrainingProgressBloc extends Bloc<TrainingProgressEvent, TrainingProgressState> {
  // Constructor
  TrainingProgressBloc() : super(TrainingProgressInitial()) {
    on<FetchTrainingProgress>(_onFetchTrainingProgress);
  }

  Future<void> _onFetchTrainingProgress(FetchTrainingProgress event, Emitter<TrainingProgressState> emit) async {
    emit(TrainingProgressLoading());
    try {
      final response = await TrainingProgressViewModel().postTrainingProgress(event.query);
      print("response1 ${response}");
      if (response != null) {
        emit(TrainingProgressLoaded(response));
      } else {
        emit(TrainingProgressError('Something went Wrong'));
      }
    } catch (e) {
      emit(TrainingProgressError('An unexpected error occurred: $e'));
    }
  }

}
