


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/screens/sign_in_screen_view/sign_out_bloc/sign_out_event.dart';
import 'package:q_bounce/screens/sign_in_screen_view/sign_out_bloc/sign_out_state.dart';
import 'package:q_bounce/screens/sign_in_screen_view/sign_out_bloc/sign_out_view_model.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_event.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_state.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_view_model/statistics_delete_response.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_view_model/statistics_edit_view_model.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  // Constructor
  SignOutBloc() : super(SignOutInitial()) {
    on<FetchSignOut>(_onFetchstatisticsDelete);
  }

  Future<void> _onFetchstatisticsDelete(FetchSignOut event, Emitter<SignOutState> emit) async {
    emit(SignOutLoading());

    try {
      final response = await SignOutViewModel().SignOut();
      print("response: $response"); // To debug what you're getting as a response

      if (response != null ) {
        print("Data deleted successfully");
        print("Response message: ${response.message}");  // Log the response message
        emit(SignOutLoaded(response));  // Emit the loaded state
      } else {
        emit(SignOutError('Something went Wrong'));
      }



    } catch (e) {
      print("Error in deleting: $e");
      emit(SignOutError('An unexpected error occurred: $e'));
    }
  }

}
// TODO Implement this library.