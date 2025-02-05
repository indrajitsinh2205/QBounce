import 'package:flutter/material.dart';
import 'package:q_bounce/common_widget/common_text_field.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_images.dart';
import 'package:q_bounce/constant/app_strings.dart';
import 'package:q_bounce/constant/app_text_style.dart';
import 'package:q_bounce/screens/sign_in_screen_view/sign_in_widget/common_otp.dart';

import '../../common_widget/common_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  int submit = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppImages.background(AppImages.appBackGround),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                Padding(
                  padding: const EdgeInsets.only(top: 68.0,bottom: 60),
                  child: Center(child: AppImages.image(AppImages.logo,width: 200)),
                ),
                Text(AppStrings.welCome.toUpperCase(),style: AppTextStyles.athleticStyle(fontSize: 36, fontFamily: AppTextStyles.athletic, color: AppColors.whiteColor,
                ),),
                Padding(padding: EdgeInsets.only(top: 25),
                child:  Text(AppStrings.enterMail,style: AppTextStyles.athleticStyle(fontSize: 20, fontFamily: AppTextStyles.sfPro500, color: AppColors.whiteColor,
                ),),
                ),
                submit ==0?  CommonTextField(controller: _emailController, label: '', hint: 'Email'): OTPField(),
                SizedBox(height: 25,),

              submit ==0?  InkWell(
                    onTap: () {
                      setState(() {
                        submit=1;
                      });
                    },
                    child: CommonButton(title: AppStrings.submit,color: AppColors.appColor,)):InkWell(
                  onTap: () {
                    setState(() {
                      submit=0;
                    });
                  },
                  child: CommonButton(title: AppStrings.confirm,color: AppColors.appColor,))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
