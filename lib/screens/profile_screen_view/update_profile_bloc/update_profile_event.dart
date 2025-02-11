import 'dart:io';

import 'package:q_bounce/screens/profile_screen_view/update_profile_bloc/update_profile_state.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_view_model/post_statistics_update_request.dart';

import '../profile_view_model/profile_response_model/profile_request_model.dart';

abstract class ProfileUpdateEvent {}

class FetchProfileUpdate extends ProfileUpdateEvent {
  final File? image;
  final UpdateProfileRequest postData;
  FetchProfileUpdate(this.image,this.postData);
}


