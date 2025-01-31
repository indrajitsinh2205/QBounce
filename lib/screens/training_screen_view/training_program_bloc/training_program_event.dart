abstract class TrainingProgramEvent {}

class FetchTraining extends TrainingProgramEvent {
  final String query;

  FetchTraining(this.query);
}


