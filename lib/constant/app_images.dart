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
  static const String castLogo = "assets/images/castLogo.png";
  static const String castBack = "assets/images/castBack.png";
  static const String step1 = "assets/images/step1.png";
  static const String step2 = "assets/images/step2.png";
  static const String step3 = "assets/images/step3.png";
  static const String step4 = "assets/images/step4.png";
  static const String step5 = "assets/images/step5.png";
  static const String step6 = "assets/images/step6.png";
  static const String step7 = "assets/images/step7.png";
  static const String step8 = "assets/images/step8.png";
  static const String rank1 = "assets/images/rank1.png";
  static const String rank2 = "assets/images/rank2.png";
  static const String rank3 = "assets/images/rank3.png";
  static const String rank1Person = "assets/images/firstRankPerson.png";
  static const String rank2Person = "assets/images/secondRankPerson.png";
  static const String rank3Person = "assets/images/thirdRankPerson.png";
  static const String ballIcon = "assets/images/homeBallIcon.png";
  static const String leaderBG = "assets/images/leaderBG.png";


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
