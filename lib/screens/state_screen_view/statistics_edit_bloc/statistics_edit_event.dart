abstract class StatisticsEditEvent {}

class FetchStatisticsEdit extends StatisticsEditEvent {
  final int query;
  FetchStatisticsEdit(this.query);
}


