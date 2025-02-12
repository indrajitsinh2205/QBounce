



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_event.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_state.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_view_model/statistics_update_view_model.dart';

class StatisticsUpdateBloc extends Bloc<StatisticsUpdateEvent, StatisticsUpdateState> {
  // Constructor
  StatisticsUpdateBloc() : super(StatisticsUpdateInitial()) {
    on<FetchStatisticsUpdate>(_onFetchstatisticsUpdate);
  }

  Future<void> _onFetchstatisticsUpdate(FetchStatisticsUpdate event, Emitter<StatisticsUpdateState> emit) async {
    emit(StatisticsUpdateLoading());
    try {
      final response = await StatisticsUpdateViewModel().postStatisticsUpdate(event.query,event.postData);
      print("statisticsEditResponse1 ${response}");
      if (response != null) {
        emit(StatisticsUpdateLoaded(response));
      } else {
        emit(StatisticsUpdateError('Something went Wrong'));
      }
    } catch (e) {
      emit(StatisticsUpdateError('An unexpected error occurred: $e'));
    }
  }

}
// TODO Implement this library.