import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_view_model/post_statistics_update_request.dart';

abstract class StatisticsUpdateEvent {}

class FetchStatisticsUpdate extends StatisticsUpdateEvent {
  final int query;
  final PostStatisticsUpdateRequestRequestModel postData;
  FetchStatisticsUpdate(this.query,this.postData);
}


