

import 'package:bloc/bloc.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_event.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_state.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_view_model/statistics_view_model.dart';
import 'package:q_bounce/screens/training_screen_view/training_bloc/training_program_event.dart';
import 'package:q_bounce/screens/training_screen_view/training_bloc/training_program_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  // Constructor
  StatisticsBloc() : super(StatisticsInitial()) {
    on<FetchStatistics>(_onFetchstatistics);
  }

  Future<void> _onFetchstatistics(FetchStatistics event, Emitter<StatisticsState> emit) async {
    emit(StatisticsLoading());
    try {
      final response = await StatisticsViewModel().getStatistics();
      print("statisticsResponse1 ${response}");
      if (response != null) {
        emit(StatisticsLoaded(response));
      } else {
        emit(StatisticsError('No data found'));
      }
    } catch (e) {
      emit(StatisticsError('An unexpected error occurred: $e'));
    }
  }

}
// TODO Implement this library.