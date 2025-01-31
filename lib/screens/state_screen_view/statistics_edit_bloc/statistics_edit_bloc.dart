

import 'package:bloc/bloc.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_event.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_state.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_view_model/statistics_view_model.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_edit_bloc/statistics_edit_event.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_edit_bloc/statistics_edit_state.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_edit_bloc/statistics_edit_view_model/statistics_edit_view_model.dart';
import 'package:q_bounce/screens/training_screen_view/training_bloc/training_program_event.dart';
import 'package:q_bounce/screens/training_screen_view/training_bloc/training_program_state.dart';

class StatisticsEditBloc extends Bloc<StatisticsEditEvent, StatisticsEditState> {
  // Constructor
  StatisticsEditBloc() : super(StatisticsEditInitial()) {
    on<FetchStatisticsEdit>(_onFetchstatisticsEdit);
  }

  Future<void> _onFetchstatisticsEdit(FetchStatisticsEdit event, Emitter<StatisticsEditState> emit) async {
    emit(StatisticsEditLoading());
    try {
      final response = await StatisticsEditViewModel().getStatisticsEdit(event.query);
      print("statisticsEditResponse1 ${response}");
      if (response != null) {
        emit(StatisticsEditLoaded(response));
      } else {
        emit(StatisticsEditError('No data found'));
      }
    } catch (e) {
      emit(StatisticsEditError('An unexpected error occurred: $e'));
    }
  }

}
// TODO Implement this library.