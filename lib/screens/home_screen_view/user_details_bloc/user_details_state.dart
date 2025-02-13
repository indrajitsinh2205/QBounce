



import 'package:q_bounce/screens/home_screen_view/user_details_bloc/user_details_response.dart';

abstract class UserDetailsState {}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailsLoading extends UserDetailsState {}

class UserDetailsLoaded extends UserDetailsState {
  final UserDetailsResponse userDetailsResponse;

  UserDetailsLoaded(this.userDetailsResponse);
}

class UserDetailsError extends UserDetailsState {
  final String errorMessage;

  UserDetailsError(this.errorMessage);
}
