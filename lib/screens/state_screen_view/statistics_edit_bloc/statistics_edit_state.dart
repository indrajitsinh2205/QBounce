

import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_view_model/GetStatisticsResponse.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_edit_bloc/statistics_edit_view_model/GetStatisticsEditResponse.dart';

abstract class StatisticsEditState {}

class StatisticsEditInitial extends StatisticsEditState {}

class StatisticsEditLoading extends StatisticsEditState {}

class StatisticsEditLoaded extends StatisticsEditState {
  final GetStatisticsEditResponse getStatisticsEditResponse;

  StatisticsEditLoaded(this.getStatisticsEditResponse);
}

class StatisticsEditError extends StatisticsEditState {
  final String errorMessage;

  StatisticsEditError(this.errorMessage);
}
