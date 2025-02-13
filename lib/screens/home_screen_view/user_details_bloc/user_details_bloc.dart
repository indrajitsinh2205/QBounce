

import 'package:bloc/bloc.dart';
import 'package:q_bounce/screens/home_screen_view/user_details_bloc/user_details_event.dart';
import 'package:q_bounce/screens/home_screen_view/user_details_bloc/user_details_state.dart';
import 'package:q_bounce/screens/home_screen_view/user_details_bloc/user_details_view_model.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_event.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_state.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_view_model/statistics_view_model.dart';
import 'package:q_bounce/screens/training_screen_view/training_bloc/training_program_event.dart';
import 'package:q_bounce/screens/training_screen_view/training_bloc/training_program_state.dart';


class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  // Constructor
  UserDetailsBloc() : super(UserDetailsInitial()) {
    on<FetchUserDetails>(_onFetchUserDetails);
  }

  Future<void> _onFetchUserDetails(FetchUserDetails event, Emitter<UserDetailsState> emit) async {
    emit(UserDetailsLoading());
    try {
      final response = await UserDetailsViewModel().getUserDetails();
      print("statisticsResponse121 ${response}");
      if (response != null) {
        emit(UserDetailsLoaded(response));
      } else {
        emit(UserDetailsError('Something went Wrong'));
      }
    } catch (e) {
      emit(UserDetailsError('An unexpected error occurred: $e'));
    }
  }

}
// TODO Implement this library.