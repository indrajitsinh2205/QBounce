

import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_view_model/GetStatisticsResponse.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_view_model/statistics_delete_response.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_edit_bloc/statistics_edit_view_model/GetStatisticsEditResponse.dart';

abstract class StatisticsDeleteState {}

class StatisticsDeleteInitial extends StatisticsDeleteState {}

class StatisticsDeleteLoading extends StatisticsDeleteState {}

class StatisticsDeleteLoaded extends StatisticsDeleteState {
  final PostStatisticsDeleteResponse postStatisticsDeleteResponse;

  StatisticsDeleteLoaded(this.postStatisticsDeleteResponse);
}


class StatisticsDeleteError extends StatisticsDeleteState {
  final String errorMessage;

  StatisticsDeleteError(this.errorMessage);
}
