

import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_view_model/GetStatisticsResponse.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_edit_bloc/statistics_edit_view_model/GetStatisticsEditResponse.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_view_model/PostStatisticsUpdateResponse.dart';

abstract class StatisticsUpdateState {}

class StatisticsUpdateInitial extends StatisticsUpdateState {}

class StatisticsUpdateLoading extends StatisticsUpdateState {}

class StatisticsUpdateLoaded extends StatisticsUpdateState {
  final PostStatisticsUpdateResponse postStatisticsUpdateResponse;

  StatisticsUpdateLoaded(this.postStatisticsUpdateResponse);
}

class StatisticsUpdateError extends StatisticsUpdateState {
  final String errorMessage;

  StatisticsUpdateError(this.errorMessage);
}
