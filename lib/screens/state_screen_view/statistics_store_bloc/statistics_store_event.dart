import 'package:q_bounce/screens/state_screen_view/statistics_store_bloc/statistics_store_view_model/statistics_store_request.dart';

abstract class StatisticsStoreEvent {}

class FetchStatisticsStore extends StatisticsStoreEvent {
  final PostStatisticsStoreRequestModel postData;
  FetchStatisticsStore(this.postData);
}


