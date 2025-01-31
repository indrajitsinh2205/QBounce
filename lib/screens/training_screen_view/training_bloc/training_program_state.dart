import '../training_view_model/TrainingVideoResponse.dart';


abstract class TrainingVideoState {}

class TrainingVideoInitial extends TrainingVideoState {}

class TrainingVideoLoading extends TrainingVideoState {}

class TrainingVideoLoaded extends TrainingVideoState {
  final TrainingVideoResponse trainingVideoResponse;

  TrainingVideoLoaded(this.trainingVideoResponse);
}

class TrainingVideoError extends TrainingVideoState {
  final String errorMessage;

  TrainingVideoError(this.errorMessage);
}
