



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/screens/profile_screen_view/update_profile_bloc/update_profile_event.dart';
import 'package:q_bounce/screens/profile_screen_view/update_profile_bloc/update_profile_state.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_event.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_state.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_view_model/statistics_update_view_model.dart';

import '../profile_view_model/profile_view_model/update_profile_view_model.dart';

class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
  // Constructor
  ProfileUpdateBloc() : super(ProfileUpdateInitial()) {
    on<FetchProfileUpdate>(_onFetchstatisticsUpdate);
  }

  Future<void> _onFetchstatisticsUpdate(FetchProfileUpdate event, Emitter<ProfileUpdateState> emit) async {
    emit(ProfileUpdateLoading());
    try {
      final response = await UpdateProfileViewModel().updateProfile(event.postData,event.image);
      print("statisticsEditResponse1 ${response}");
      if (response != null) {
        emit(ProfileUpdateLoaded(response));
      } else {
        emit(ProfileUpdateError('No data found'));
      }
    } catch (e) {
      emit(ProfileUpdateError('An unexpected error occurred: $e'));
    }
  }

}
// TODO Implement this library.