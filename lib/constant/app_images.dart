import 'package:flutter/material.dart';

class AppImages {
  /// home Devices

  static const String homeDevice = "assets/images/home-device.png";
  static const String hadingBG = "assets/images/hading-bg.png";
  static const String device = "assets/images/device.png";
  static const String phoneDevice = "assets/images/phone-device.png";
  static const String connectingLogo = "assets/images/connecting-logo.png";
  static const String backIcon = "assets/images/back-icon.png";
  static const String submitIcon = "assets/images/submit-Icon.png";
  static const String onScale = "assets/images/on-scale.png";
  static const String scanner = "assets/images/scanner.png";
  static const String search = "assets/images/search-icon.png";
  static const String clearIcon = "assets/images/cancel-icon.png";
  static const String calender = "assets/images/calender.png";
  static const String rightArrow = "assets/images/right-arrow.png";
  static const String rightGreyArrow = "assets/images/grey-right-arrow.png";
  static const String mediumKcal = "assets/images/medium-kcal.png";
  static const String highKcal = "assets/images/high-kcal.png";
  static const String splashBG = "assets/images/splashBG.png";

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
