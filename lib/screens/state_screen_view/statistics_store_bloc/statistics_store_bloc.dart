



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_store_bloc/statistics_store_event.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_store_bloc/statistics_store_state.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_store_bloc/statistics_store_view_model/statistics_store_view_model.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_event.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_state.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_view_model/statistics_update_view_model.dart';

class StatisticsStoreBloc extends Bloc<StatisticsStoreEvent, StatisticsStoreState> {
  // Constructor
  StatisticsStoreBloc() : super(StatisticsStoreInitial()) {
    on<FetchStatisticsStore>(_onFetchstatisticsUpdate);
  }

  Future<void> _onFetchstatisticsUpdate(FetchStatisticsStore event, Emitter<StatisticsStoreState> emit) async {
    emit(StatisticsStoreLoading());
    try {
      final response = await StatisticsStoreViewModel().postStatisticsStore(event.postData);
      print("statisticsEditResponse1 ${response}");
      if (response != null) {
        emit(StatisticsStoreLoaded(response));
      } else {
        emit(StatisticsStoreError('Something went Wrong'));
      }
    } catch (e) {
      emit(StatisticsStoreError('An unexpected error occurred: $e'));
    }
  }

}
// TODO Implement this library.