abstract class TrainingProgressEvent {}

class FetchTrainingProgress extends TrainingProgressEvent {
  final Map<String,dynamic> query;

  FetchTrainingProgress(this.query);
}


