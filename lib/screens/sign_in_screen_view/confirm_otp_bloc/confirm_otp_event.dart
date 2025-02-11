abstract class ConfirmOTPEvent {}

class FetchConfirmOTP extends ConfirmOTPEvent {
  final Map<String,dynamic> query;
  FetchConfirmOTP(this.query);
}


