import 'package:flutter/material.dart';

class AppImages {
  /// home Devices

  static const String appBackGround = "assets/images/appBack.png";
  static const String landing1 = "assets/images/landing1.png";
  static const String landing2 = "assets/images/landing2.png";
  static const String landing3 = "assets/images/landing3.png";
  static const String logo = "assets/images/logo.png";
  static const String playerG = "assets/images/playerG.png";
  static const String playerB = "assets/images/playerB.png";
  static const String howItGroup = "assets/images/howItGroup.png";
  static const String teacher = "assets/images/teacher.png";
  static const String player = "assets/images/player.png";


  /// Returns an Image widget for a specific asset.
  static Widget image(String assetPath, {double? width, double? height, BoxFit? fit}) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
    );
  }

  static BoxDecoration background(String assetPath, {BoxFit fit = BoxFit.fill}) {
    return BoxDecoration(
      color: Colors.transparent,
      image: DecorationImage(
        image: AssetImage(assetPath),
        fit: fit,
      ),
    );
  }

}
