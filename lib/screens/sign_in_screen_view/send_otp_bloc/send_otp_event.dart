abstract class SendOTPEvent {}

class FetchSendOTP extends SendOTPEvent {
  final Map<String,dynamic> query;
  FetchSendOTP(this.query);
}


