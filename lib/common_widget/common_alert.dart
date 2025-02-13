import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/app_services/app_preferences.dart';
import 'package:q_bounce/app_services/navigation_service.dart';
import 'package:q_bounce/screens/sign_in_screen_view/sign_out_bloc/sign_out_bloc.dart';

import '../constant/app_color.dart';
import '../constant/app_images.dart';
import '../constant/app_strings.dart';
import '../constant/app_text_style.dart';
import '../screens/sign_in_screen_view/sign_out_bloc/sign_out_event.dart';
import '../screens/sign_in_screen_view/sign_out_bloc/sign_out_state.dart';
import 'common_button.dart';
import 'custom_snackbar.dart';

class CommonAlert {
  static showAlertDialog(BuildContext context,String confirm,String subTitle,VoidCallback confirmAction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider<SignOutBloc>(
          create: (BuildContext context) => SignOutBloc(),
          child: AlertDialog(
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
                  BlocConsumer<SignOutBloc, SignOutState>(
                    builder: (context, state) {
                      if (state is SignOutLoading) {
                        return CircularProgressIndicator(color: AppColors.appColor,);
                      }
                      return InkWell(
                        onTap: () async{

                          BlocProvider.of<SignOutBloc>(context).add(FetchSignOut());
                          NavigationService.navigateTo(NavigationService.signIn);
                          AppPreferences().removeToken();
                          AppPreferences().removeEmail();
                          AppPreferences().removeImage();
                          AppPreferences().removeName();
                        },
                        child: Expanded(
                          child: CommonButton(title: confirm, color: AppColors.appColor,horizontal: 10,font: 14,),
                        ),
                      );
                    },
                    listener: (context, state) {
                      if (state is SignOutLoaded) {
                        // NavigationService.navigateTo(NavigationService.signIn);
                        // setState(() {
                        //   statisticsData.removeWhere((element) => element.id == deletingId);
                        //   deletingId = null;
                        //   Navigator.pop(context);
                        // });
                        ScaffoldMessengerHelper.showMessage(state.signOutResponse.message.toString());
                      } else if (state is SignOutError) {
                        ScaffoldMessengerHelper.showMessage(state.errorMessage
                        );
                        // setState(() {
                        //   deletingId = null;
                        // });
                      }
                    },
                  ),

                ],
              ),
            ],
          ),
        );
      },
    );
  }

}