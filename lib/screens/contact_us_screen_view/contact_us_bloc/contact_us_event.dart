import 'package:q_bounce/screens/state_screen_view/statistics_store_bloc/statistics_store_view_model/statistics_store_request.dart';

import '../contact_us_view_model/contact_us_request_model.dart';

abstract class ContactUsEvent {}

class FetchContactUs extends ContactUsEvent {
  final ContactUsRequestModel postData;
  FetchContactUs(this.postData);
}


