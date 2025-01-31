abstract class StatisticsDeleteEvent {}

class FetchStatisticsDelete extends StatisticsDeleteEvent {
  final int query;
  FetchStatisticsDelete(this.query);
}


