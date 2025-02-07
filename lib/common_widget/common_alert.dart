import 'package:flutter/material.dart';

import '../constant/app_color.dart';
import '../constant/app_images.dart';
import '../constant/app_strings.dart';
import '../constant/app_text_style.dart';
import 'common_button.dart';

class CommonAlert {
  static showAlertDialog(BuildContext context,String confirm,String subTitle,VoidCallback confirmAction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.alertColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          title: Center(
            child: AppImages.image(
              AppImages.confirmDelete,
              height: 78,
              width: 80,
              fit: BoxFit.fitWidth,
            ),
          ),
          content: SizedBox(
            width: 300, // Set a fixed width for the dialog
            child: Column(
              mainAxisSize: MainAxisSize.min, // Prevent infinite height
              children: [
                Text(
                  AppStrings.areYouSure,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.athleticStyle(
                    fontSize: 24,
                    fontFamily: AppTextStyles.sfPro700,
                    color: AppColors.whiteColor,
                  ),
                ),
                SizedBox(height: 8), // Add spacing
                Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.getOpenSansBoldGoogleFont(
                    18, AppColors.whiteColor, false,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute buttons evenly
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CommonButton(title: AppStrings.cancel, color: AppColors.faq,horizontal: 10,font: 14,)),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: InkWell(
                      onTap: () {
                  confirmAction();
                  },
                      child: CommonButton(title: confirm, color: AppColors.appColor,horizontal: 10,font: 14,)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

}