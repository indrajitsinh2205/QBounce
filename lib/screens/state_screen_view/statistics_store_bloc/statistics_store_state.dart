

import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_view_model/GetStatisticsResponse.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_edit_bloc/statistics_edit_view_model/GetStatisticsEditResponse.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_store_bloc/statistics_store_view_model/PostStatisticsStoreResponse.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_view_model/PostStatisticsUpdateResponse.dart';

abstract class StatisticsStoreState {}

class StatisticsStoreInitial extends StatisticsStoreState {}

class StatisticsStoreLoading extends StatisticsStoreState {}

class StatisticsStoreLoaded extends StatisticsStoreState {
  final PostStatisticsStoreResponse postStatisticsStoreResponse;

  StatisticsStoreLoaded(this.postStatisticsStoreResponse);
}

class StatisticsStoreError extends StatisticsStoreState {
  final String errorMessage;

  StatisticsStoreError(this.errorMessage);
}
