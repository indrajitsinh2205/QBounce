import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/screens/leaderboard_screen_view/leaderboard_screen.dart';
import 'package:q_bounce/screens/sign_in_screen_view/sign_in_screen.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_screen.dart';
import 'package:q_bounce/screens/training_screen_view/training_bloc/training_program_bloc.dart';

import '../common_widget/common_app_bar.dart';
import '../screens/how_to_use_screen_view/how_to_use_screen.dart';
import '../screens/leaderboard_screen_view/leaderboard_bloc/leader_board_bloc.dart';
import '../screens/on_boarding_screen_view/on_boarding_screen.dart';
import '../screens/state_screen_view/statistics_bloc/statistics_bloc.dart';
import '../screens/state_screen_view/statistics_delete_bloc/statistics_delete_bloc.dart';
import '../screens/state_screen_view/statistics_edit_bloc/statistics_edit_bloc.dart';
import '../screens/state_screen_view/statistics_store_bloc/statistics_store_bloc.dart';
import '../screens/state_screen_view/statistics_update_bloc/statistics_update_bloc.dart';
import '../screens/statistics_edit_view/statistics_edit_screen.dart';
import '../screens/training_screen_view/training_program_bloc/training_program_bloc.dart';
import '../screens/training_screen_view/training_progress_bloc/training_progress_bloc.dart';
import '../screens/training_screen_view/training_screen.dart';


class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Screen Name
  static const String statistics = "statistics";
  static const String edit = "edit";
  static const String leaderboard = "leaderboard";
  static const String training = "training";
  static const String signIn = "signing";
  static const String howToUse = "howToUse";
  static const String drawer = "drawer";

  /// Generate routes based on route settings
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.arguments is String) {
      final String dashboardMessage = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => _handleRoute(settings, dashboardMessage),
      );
    }else if(settings.arguments is int){
      final int dashboardMessage = settings.arguments as int;
      return MaterialPageRoute(
        builder: (context) => _handleRoute(settings, dashboardMessage),
      );

    }

    else {
      return MaterialPageRoute(
        builder: (context) => _handleRoute(settings, 'Default Message'),
      );
    }
  }

  /// Handles route logic with switch-case
  static Widget _handleRoute(RouteSettings settings, var dashboardMessage) {
    switch (settings.name) {
      case '/':
        return OnboardingScreen();
      case 'training':
        return MultiBlocProvider(
            providers: [
              BlocProvider<TrainingProgramBloc>(
                create: (BuildContext context) => TrainingProgramBloc(),
              ),
              BlocProvider<TrainingVideoBloc>(
                create: (BuildContext context) => TrainingVideoBloc(),
              ),
              BlocProvider<TrainingProgressBloc>(
                create: (BuildContext context) => TrainingProgressBloc(),
              ),
            ],
            child: TrainingScreen());
      case statistics:
        return  MultiBlocProvider(
            providers: [
              BlocProvider<StatisticsBloc>(
                create: (BuildContext context) => StatisticsBloc(),
              ),
              BlocProvider<StatisticsDeleteBloc>(
                create: (BuildContext context) => StatisticsDeleteBloc(),
              ),
            ],
            child: StatisticsScreen());

      case edit:
        final argument = settings.arguments;
        int id = 0;

        if (argument is String) {
          id = int.tryParse(argument) ?? 0;
        } else if (argument is int) {
          id = argument; // Already an int, no parsing needed
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider<StatisticsEditBloc>(
              create: (BuildContext context) => StatisticsEditBloc(),
            ),
            BlocProvider<StatisticsUpdateBloc>(
              create: (BuildContext context) => StatisticsUpdateBloc(),
            ),
            BlocProvider<StatisticsStoreBloc>(
              create: (BuildContext context) => StatisticsStoreBloc(),
            ),
          ],
          child: StatisticsEditScreen(Id: id),
        );
      case leaderboard:
        return  MultiBlocProvider(
            providers: [
              BlocProvider<LeaderBoardBloc>(create: (context) => LeaderBoardBloc(),)
            ],
            child: LeaderboardScreen());
      case signIn:
        return SignInScreen();
      case howToUse:
        return HowToUseScreen();
        case drawer:
        return DrawerScreen();

      default:
        return _errorScreen();
    }
  }


  /// Fallback widget for unknown or invalid routes
  static Widget _errorScreen() {
    return Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body: const Center(child: Text("Page not found!")),
    );
  }

  /// Navigate to a specific route with optional arguments
  static Future<void> navigateTo(String routeName, {Object? arguments}) async {
    await navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  /// Navigate to a route and clear the navigation stack
  static Future<void> navigateAndRemoveUntil(String routeName, {Object? arguments}) async {
    await navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
          (route) => false,
      arguments: arguments,
    );
  }

  /// Go back to the previous route
  static void goBack() {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop();
    }
  }
}
