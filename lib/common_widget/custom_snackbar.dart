import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_services/navigation_service.dart';
import '../constant/app_color.dart';

class ScaffoldMessengerHelper {
  // GlobalKey to access the ScaffoldMessengerState
  static final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  // Getter to access the key (to be used in your MaterialApp or root widget)
  static GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
      _scaffoldMessengerKey;

  // Show a simple message
  static void showMessage(String message, {Duration duration = const Duration(seconds: 2)}) {
    // Accessing the ScaffoldMessenger globally via the key
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message,style: TextStyle(color: AppColors.whiteColor,fontSize: 12,fontWeight: FontWeight.w700)),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.appColor,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      ),
    );
  }


  // Show a message with a specific background color
  static void showCustomMessage(
      String message, {
        required Color backgroundColor,
        Duration duration = const Duration(seconds: 2),
      }) {
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }

  // Show a success message (Green color)
  static void showSuccessMessage(String message,
      {Duration duration = const Duration(seconds: 2)}) {
    showCustomMessage(message,
        backgroundColor: Colors.green, duration: duration);
  }

  // Show an error message (Red color)
  static void showErrorMessage(String message,
      {Duration duration = const Duration(seconds: 2)}) {
    showCustomMessage(message, backgroundColor: Colors.red, duration: duration);
  }

  // Show an info message (Blue color)
  static void showInfoMessage(String message,
      {Duration duration = const Duration(seconds: 2)}) {
    showCustomMessage(message,
        backgroundColor: Colors.blue, duration: duration);
  }
  // static void showBLEPermissionDialog(String subTitle) {
  //   showDialog(
  //     context: NavigationService.navigatorKey.currentState!.context,
  //     builder: (BuildContext context) {
  //       return CupertinoAlertDialog(
  //         title: Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 12.0),
  //           child: Text(
  //             'Permission Denied',
  //             style: AppTextStyles.getOpenSansSemiBoldGoogleFont(22, AppColors.primary, false),
  //           ),
  //         ),
  //         content: Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 12.0),
  //           child: Text(
  //             subTitle,
  //             style: AppTextStyles.getOpenSansGoogleFont(18, AppColors.blackColor, false),
  //           ),
  //         ),
  //         actions: <Widget>[
  //           CupertinoDialogAction(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text(
  //               'Cancel',
  //             ),
  //           ),
  //           CupertinoDialogAction(
  //             onPressed: () async {
  //               await openAppSettings();
  //               Navigator.of(context).pop();
  //             },
  //             child: Text(
  //               'Open Settings',
  //               style: TextStyle(fontSize: 18),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
