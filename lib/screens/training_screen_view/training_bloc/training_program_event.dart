abstract class TrainingVideoEvent {}

class FetchTrainingVideo extends TrainingVideoEvent {
  final String query;

  FetchTrainingVideo(this.query);
}


