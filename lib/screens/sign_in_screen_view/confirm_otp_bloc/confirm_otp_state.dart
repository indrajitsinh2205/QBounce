

import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_view_model/GetStatisticsResponse.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_view_model/statistics_delete_response.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_edit_bloc/statistics_edit_view_model/GetStatisticsEditResponse.dart';

import '../auth_response_model/confirm_otp_response.dart';

abstract class ConfirmOTPState {}

class ConfirmOTPInitial extends ConfirmOTPState {}

class ConfirmOTPLoading extends ConfirmOTPState {}

class ConfirmOTPLoaded extends ConfirmOTPState {
  final ConfirmOtpResponse postConfirmOTPResponse;

  ConfirmOTPLoaded(this.postConfirmOTPResponse);
}


class ConfirmOTPError extends ConfirmOTPState {
  final String errorMessage;

  ConfirmOTPError(this.errorMessage);
}
