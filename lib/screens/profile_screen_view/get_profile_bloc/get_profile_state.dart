


import '../profile_view_model/profile_response_model/get_profile_response.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final GetProfileResponse getProfileResponse;

  ProfileLoaded(this.getProfileResponse);
}

class ProfileError extends ProfileState {
  final String errorMessage;

  ProfileError(this.errorMessage);
}
