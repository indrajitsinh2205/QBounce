


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_event.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_state.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_view_model/statistics_delete_response.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_view_model/statistics_edit_view_model.dart';

class StatisticsDeleteBloc extends Bloc<StatisticsDeleteEvent, StatisticsDeleteState> {
  // Constructor
  StatisticsDeleteBloc() : super(StatisticsDeleteInitial()) {
    on<FetchStatisticsDelete>(_onFetchstatisticsDelete);
  }

  Future<void> _onFetchstatisticsDelete(FetchStatisticsDelete event, Emitter<StatisticsDeleteState> emit) async {
    emit(StatisticsDeleteLoading());

    try {
      final response = await StatisticsDeleteViewModel().getStatisticsDelete(event.query);
      print("response: $response"); // To debug what you're getting as a response

      if (response != null && response is PostStatisticsDeleteResponse) {
        print("Data deleted successfully");
        print("Response message: ${response.message}");  // Log the response message
        emit(StatisticsDeleteLoaded(response));  // Emit the loaded state
      } else {
        emit(StatisticsDeleteError('Something went Wrong'));
      }



    } catch (e) {
      print("Error in deleting: $e");
      emit(StatisticsDeleteError('An unexpected error occurred: $e'));
    }
  }

}
// TODO Implement this library.