import 'package:flutter/material.dart';
import 'package:q_bounce/app_services/common_Capital.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_text_style.dart';
import 'package:q_bounce/screens/faq_screen_view/faq_data.dart';

import '../../constant/app_strings.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {


  int? expandedIndex; // To track which tile is expanded

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.transparent,

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.heyThere.toUpperCase(),style: AppTextStyles.athleticStyle(fontSize: 32, fontFamily: AppTextStyles.athletic, color: AppColors.whiteColor),),
              Text(AppStrings.howToUse2,style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro400, color: AppColors.whiteColor),),
              SizedBox(height: 10,),
              Column(

                children: List.generate(FAQData.faqList.length, (index) {
                  return Card(

                    color: AppColors.faq,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ExpansionTile(
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white,

                      key: Key(index.toString()), // Ensures correct state tracking
                      initiallyExpanded: expandedIndex == index,
                      title: Text(
                        CommonCapital.capitalizeEachWord(
                        FAQData.faqList[index]["title"]!),
                        style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro500, color: AppColors.whiteColor)
                      ),
                      onExpansionChanged: (expanded) {
                        setState(() {
                          expandedIndex = expanded ? index : null; // Only one expands
                        });
                      },
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            CommonCapital.capitalizeEachWord(
                            FAQData.faqList[index]["content"]!),
                              style: AppTextStyles.athleticStyle(fontSize: 12, fontFamily: AppTextStyles.sfPro400, color: AppColors.whiteColor)
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
