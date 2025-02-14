import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/home_screen_view/home_screen.dart';
import '../screens/leaderboard_screen_view/leaderboard_bloc/leader_board_bloc.dart';
import '../screens/training_screen_view/training_program_bloc/training_program_bloc.dart';

class CommonCapital{
  static String capitalizeEachWord(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }
}


class GlobleValue {
  static ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  static ValueNotifier<String> session = ValueNotifier<String>('');
  static ValueNotifier<String?> selectedText = ValueNotifier<String?>(null);
  static ValueNotifier<String> selectedDate = ValueNotifier<String>('');
  static ValueNotifier<String> selectedButton = ValueNotifier<String>('Beginner');
  static ValueNotifier<int> button = ValueNotifier<int>(0);
  static ValueNotifier<int> numericCount = ValueNotifier<int>(0);
  static ValueNotifier<int> currentIndex = ValueNotifier<int>(0);
  static ValueNotifier<Widget?> overlayScreen = ValueNotifier<Widget?>(null);

  static ValueNotifier<Widget> selectedScreen = ValueNotifier<Widget>(MultiBlocProvider(
  providers: [
  BlocProvider<LeaderBoardBloc>(
  create: (context) => LeaderBoardBloc(),
  ),
  BlocProvider<TrainingProgramBloc>(
  create: (context) => TrainingProgramBloc(),
  ),
  BlocProvider<TrainingProgramBloc>(
  create: (context) => TrainingProgramBloc(),
  ),
  ],
  child: HomeScreen(),
  ));
}