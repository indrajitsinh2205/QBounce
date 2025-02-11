



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/screens/sign_in_screen_view/auth_view_model/get_otp_view_model.dart';
import 'package:q_bounce/screens/sign_in_screen_view/send_otp_bloc/send_otp_event.dart';
import 'package:q_bounce/screens/sign_in_screen_view/send_otp_bloc/send_otp_state.dart';

import '../auth_response_model/get_otp_response.dart';

class SendOTPBloc extends Bloc<SendOTPEvent, SendOTPState> {
  // Constructor
  SendOTPBloc() : super(SendOTPInitial()) {
    on<FetchSendOTP>(_onFetchstatisticsDelete);
  }

  Future<void> _onFetchstatisticsDelete(FetchSendOTP event, Emitter<SendOTPState> emit) async {
    emit(SendOTPLoading());

    try {
      final response = await SendOtpViewModel().sendOtp(event.query);
      print("response: $response"); // To debug what you're getting as a response

      if (response != null && response is SendOtpResponse) {
        print("Data deleted successfully");
        print("Response message: ${response.message}");  // Log the response message
        emit(SendOTPLoaded(response));  // Emit the loaded state
      } else {
        print("Error: No data found");
        emit(SendOTPError('No data found'));
      }



    } catch (e) {
      print("Error in deleting: $e");
      emit(SendOTPError('An unexpected error occurred: $e'));
    }
  }

}
// TODO Implement this library.