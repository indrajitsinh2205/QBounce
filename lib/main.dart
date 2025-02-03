import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_services/navigation_service.dart';
import 'common_widget/custom_snackbar.dart';

void main(){
  String capitalizeEachWord(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  String sentence = 'this is flutter';
  String capitalizedSentence = capitalizeEachWord(sentence);
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
      initialRoute: NavigationService.drawer,
      debugShowCheckedModeBanner: false,
    );
  }
}
