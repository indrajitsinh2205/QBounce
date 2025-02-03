import 'package:flutter/material.dart';
import 'package:q_bounce/screens/terms_and_conditons_screen_view/terms_data.dart';

import '../../app_services/common_Capital.dart';
import '../../constant/app_color.dart';
import '../../constant/app_strings.dart';
import '../../constant/app_text_style.dart';

class TermsAndConditonsScreen extends StatefulWidget {
  const TermsAndConditonsScreen({super.key});

  @override
  State<TermsAndConditonsScreen> createState() => _TermsAndConditonsScreenState();
}

class _TermsAndConditonsScreenState extends State<TermsAndConditonsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.terms.toUpperCase(),style: AppTextStyles.athleticStyle(fontSize: 32, fontFamily: AppTextStyles.athletic, color: AppColors.whiteColor),),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:  TermsAndCond.termsAndConditions.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(top: 25),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: AppColors.faq,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Text(
                          TermsAndCond.termsAndConditions[index]["title"]!.toUpperCase(),
                          style: AppTextStyles.athleticStyle(fontSize: 12, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor)
                      ),
                      SizedBox(height: 10,),
                      Text(
                          CommonCapital.capitalizeEachWord(TermsAndCond.termsAndConditions[index]["content"]!)
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
