

import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_view_model/GetStatisticsResponse.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_edit_bloc/statistics_edit_view_model/GetStatisticsEditResponse.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_store_bloc/statistics_store_view_model/PostStatisticsStoreResponse.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_view_model/PostStatisticsUpdateResponse.dart';

import '../contact_us_view_model/contact_us_response.dart';

abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}

class ContactUsLoading extends ContactUsState {}

class ContactUsLoaded extends ContactUsState {
  final ContactUsResponse contactUsResponse;

  ContactUsLoaded(this.contactUsResponse);
}

class ContactUsError extends ContactUsState {
  final String errorMessage;

  ContactUsError(this.errorMessage);
}
