abstract class StatisticsEvent {}

class FetchStatistics extends StatisticsEvent {

  FetchStatistics();
}
// Add this event to your StatisticsEvent
class RemoveStatistic extends StatisticsEvent {
  final int id;

  RemoveStatistic(this.id);
}



