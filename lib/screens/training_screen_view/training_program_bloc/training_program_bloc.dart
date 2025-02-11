

import 'package:bloc/bloc.dart';
import 'package:q_bounce/screens/training_screen_view/training_program_bloc/training_program_event.dart';
import 'package:q_bounce/screens/training_screen_view/training_program_bloc/training_program_state.dart';

import '../training_view_model/training_view_model.dart';

class TrainingProgramBloc extends Bloc<TrainingProgramEvent, TrainingProgramState> {
  // Constructor
  TrainingProgramBloc() : super(TrainingInitial()) {
    on<FetchTraining>(_onFetchTraining);
  }

  Future<void> _onFetchTraining(FetchTraining event, Emitter<TrainingProgramState> emit) async {
    emit(TrainingLoading());
    try {
      final response = await TrainingViewModel().getTraining(event.query);
      print("response1 ii${response?.data}ii");
      if (response != null) {
        emit(TrainingLoaded(response));
      } else {
        emit(TrainingError('No data found'));
      }
    } catch (e) {
      emit(TrainingError('An unexpected error occurred: $e'));
    }
  }

}
