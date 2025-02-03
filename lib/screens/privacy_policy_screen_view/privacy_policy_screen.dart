import 'package:flutter/material.dart';
import 'package:q_bounce/app_services/common_Capital.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/screens/privacy_policy_screen_view/policy_data.dart';

import '../../constant/app_strings.dart';
import '../../constant/app_text_style.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.privacyPolicy.toUpperCase(),style: AppTextStyles.athleticStyle(fontSize: 32, fontFamily: AppTextStyles.athletic, color: AppColors.whiteColor),),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:  PrivacyData.privacyPolicy.length,
              itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(top: 25),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.faq,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Text(
                        PrivacyData.privacyPolicy[index]["title"]!.toUpperCase(),
                        style: AppTextStyles.athleticStyle(fontSize: 12, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor)
                    ),
                    SizedBox(height: 20,),
                    Text(
                      CommonCapital.capitalizeEachWord(PrivacyData.privacyPolicy[index]["content"]!)
                        ,
                        style: AppTextStyles.getOpenSansGoogleFont(10,AppColors.whiteColor,false)
                    ),
                    SizedBox(height: 10,),
                  ],
                ) ,
              );
            },),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
