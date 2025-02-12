

import 'package:bloc/bloc.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_event.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_state.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_view_model/statistics_view_model.dart';
import 'package:q_bounce/screens/training_screen_view/training_bloc/training_program_event.dart';
import 'package:q_bounce/screens/training_screen_view/training_bloc/training_program_state.dart';

import '../profile_view_model/profile_view_model/get_profile_view_model.dart';
import 'get_profile_event.dart';
import 'get_profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  // Constructor
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfile>(_onFetchstatistics);
  }

  Future<void> _onFetchstatistics(FetchProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final response = await GetProfileViewModel().getProfile();
      print("statisticsResponse1 ${response}");
      if (response != null) {
        emit(ProfileLoaded(response));
      } else {
        emit(ProfileError('Something went Wrong'));
      }
    } catch (e) {
      emit(ProfileError('An unexpected error occurred: $e'));
    }
  }

}
// TODO Implement this library.