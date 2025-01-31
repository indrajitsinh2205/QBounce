import 'package:q_bounce/screens/training_screen_view/training_view_model/TrainingResponse.dart';


abstract class TrainingProgramState {}

class TrainingInitial extends TrainingProgramState {}

class TrainingLoading extends TrainingProgramState {}

class TrainingLoaded extends TrainingProgramState {
  final TrainingResponse trainingResponse;

  TrainingLoaded(this.trainingResponse);
}

class TrainingError extends TrainingProgramState {
  final String errorMessage;

  TrainingError(this.errorMessage);
}
