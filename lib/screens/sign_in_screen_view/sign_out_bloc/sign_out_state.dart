

import 'package:q_bounce/screens/sign_in_screen_view/sign_out_bloc/sign_out_response.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_view_model/GetStatisticsResponse.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_view_model/statistics_delete_response.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_edit_bloc/statistics_edit_view_model/GetStatisticsEditResponse.dart';

abstract class SignOutState {}

class SignOutInitial extends SignOutState {}

class SignOutLoading extends SignOutState {}

class SignOutLoaded extends SignOutState {
  final SignOutResponse signOutResponse;

  SignOutLoaded(this.signOutResponse);
}


class SignOutError extends SignOutState {
  final String errorMessage;

  SignOutError(this.errorMessage);
}
