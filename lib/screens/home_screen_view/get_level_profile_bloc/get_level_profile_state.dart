
import '../get_level_profile_view_model/get_level_profile_response.dart';

abstract class LevelProfileState {}

class LevelProfileInitial extends LevelProfileState {}

class LevelProfileLoading extends LevelProfileState {}

class LevelProfileLoaded extends LevelProfileState {
  final GetLevelProfileResponse getLevelProfileResponse;

  LevelProfileLoaded(this.getLevelProfileResponse);
}

class LevelProfileError extends LevelProfileState {
  final String errorMessage;

  LevelProfileError(this.errorMessage);
}
