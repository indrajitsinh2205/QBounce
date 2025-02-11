



import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_response_model/confirm_otp_response.dart';
import '../auth_view_model/confirm_otp_view_model.dart';
import 'confirm_otp_event.dart';
import 'confirm_otp_state.dart';

class ConfirmOTPBloc extends Bloc<ConfirmOTPEvent, ConfirmOTPState> {
  ConfirmOTPBloc() : super(ConfirmOTPInitial()) {
    on<FetchConfirmOTP>(_onFetchstatisticsDelete);
  }

  Future<void> _onFetchstatisticsDelete(FetchConfirmOTP event, Emitter<ConfirmOTPState> emit) async {
    emit(ConfirmOTPLoading());

    try {
      final response = await ConfirmOtpViewModel().confirmOTP(event.query);
      print("response: $response"); // To debug what you're getting as a response

      if (response != null /*&& response is ConfirmOtpRespons*/) {
        print("Data deleted successfully");
        print("Response message: ${response.data}");  // Log the response message
        emit(ConfirmOTPLoaded(response));  // Emit the loaded state
      } else {
        print("Error: No data found");
        emit(ConfirmOTPError('No data found'));
      }



    } catch (e) {
      print("Error in deleting: $e");
      emit(ConfirmOTPError('An unexpected error occurred: $e'));
    }
  }

}
// TODO Implement this library.