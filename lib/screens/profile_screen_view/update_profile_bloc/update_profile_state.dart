


import '../profile_view_model/profile_response_model/update_proifle_response.dart';

abstract class ProfileUpdateState {}

class ProfileUpdateInitial extends ProfileUpdateState {}

class ProfileUpdateLoading extends ProfileUpdateState {}

class ProfileUpdateLoaded extends ProfileUpdateState {
  final UpdateProfileResponse updateProfileResponse;

  ProfileUpdateLoaded(this.updateProfileResponse);
}

class ProfileUpdateError extends ProfileUpdateState {
  final String errorMessage;

  ProfileUpdateError(this.errorMessage);
}
