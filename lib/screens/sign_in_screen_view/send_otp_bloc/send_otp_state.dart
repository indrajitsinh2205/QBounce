

import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_view_model/GetStatisticsResponse.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_view_model/statistics_delete_response.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_edit_bloc/statistics_edit_view_model/GetStatisticsEditResponse.dart';

import '../auth_response_model/get_otp_response.dart';

abstract class SendOTPState {}

class SendOTPInitial extends SendOTPState {}

class SendOTPLoading extends SendOTPState {}

class SendOTPLoaded extends SendOTPState {
  final SendOtpResponse SendOTPResponse;

  SendOTPLoaded(this.SendOTPResponse);
}


class SendOTPError extends SendOTPState {
  final String errorMessage;

  SendOTPError(this.errorMessage);
}
