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
  static const String delete = "assets/images/delete.png";
  static const String ballImage = "assets/images/ball.png";
  static const String edit = "assets/images/edit.png";
  static const String levelFrame = "assets/images/level_frame.png";
  static const String stateBG = "assets/images/stateBG.png";
  static const String confirmDelete = "assets/images/confirmDelete.png";
  static const String drawerBG = "assets/images/drawerBG.png";
  static const String lock = "assets/images/lock.png";
  static const String upload = "assets/images/upload.png";
  static const String levelLock = "assets/images/levelLock.png";
  static const String rightArrow = "assets/images/rightArrow.png";
  static const String calenderIcon = "assets/images/calender_Icon.png";

  /// bottomSheet
  static const String home = "assets/images/home.png";
  static const String state = "assets/images/state.png";
  static const String cart = "assets/images/cart.png";
  static const String leader = "assets/images/leader.png";

  /// drawer
  static const String howToUse = "assets/images/htuIcon.png";
  static const String cast = "assets/images/castIcon.png";
  static const String terms = "assets/images/termIcon.png";
  static const String privacy = "assets/images/privacyIcon.png";
  static const String faq = "assets/images/faqIcon.png";
  static const String contact = "assets/images/contactIcon.png";
  static const String signOut = "assets/images/signOutIcon.png";
  static const String drawerEdit = "assets/images/drawerEdit.png";
  static const String drawerIcon = "assets/images/drawerIcon.png";
  static const String downArrow = "assets/images/downArrow.png";


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
