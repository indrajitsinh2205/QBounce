

import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_view_model/GetStatisticsResponse.dart';

abstract class StatisticsState {}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  final GetStatisticsResponse getStatisticsResponse;

  StatisticsLoaded(this.getStatisticsResponse);
}

class StatisticsError extends StatisticsState {
  final String errorMessage;

  StatisticsError(this.errorMessage);
}
