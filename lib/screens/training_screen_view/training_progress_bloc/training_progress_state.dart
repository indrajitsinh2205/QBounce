import 'package:q_bounce/screens/training_screen_view/training_view_model/TrainingResponse.dart';

import '../training_view_model/TrainingProgress.dart';


abstract class TrainingProgressState {}

class TrainingProgressInitial extends TrainingProgressState {}

class TrainingProgressLoading extends TrainingProgressState {}

class TrainingProgressLoaded extends TrainingProgressState {
  final TrainingProgressResponse trainingProgressResponse;

  TrainingProgressLoaded(this.trainingProgressResponse);
}

class TrainingProgressError extends TrainingProgressState {
  final String errorMessage;

  TrainingProgressError(this.errorMessage);
}
