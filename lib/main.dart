import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_services/navigation_service.dart';
import 'common_widget/custom_snackbar.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: ScaffoldMessengerHelper.scaffoldMessengerKey, // Set the key here

      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: NavigationService.generateRoute,
      initialRoute: NavigationService.leaderboard,
      debugShowCheckedModeBanner: false,
    );
  }
}
