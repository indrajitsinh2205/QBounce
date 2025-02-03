import 'package:flutter/material.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_strings.dart';
import 'package:q_bounce/constant/app_text_style.dart';

import '../../common_widget/common_app_bar.dart';
import '../../constant/app_images.dart';

class HowToUseScreen extends StatefulWidget {
  const HowToUseScreen({super.key});

  @override
  State<HowToUseScreen> createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> {
  String capitalizeEachWord(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.heyThere.toUpperCase(),style: AppTextStyles.athleticStyle(fontSize: 32, fontFamily: AppTextStyles.athletic, color: AppColors.whiteColor),),
              Text(AppStrings.howToUse1,style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro400, color: AppColors.whiteColor),),
              SizedBox(height: 25,),
              AppImages.image(
                AppImages.playerG,
                width: double.infinity,
                height: 250,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 14),
              Text(
                AppStrings.howItWorks,
                style: AppTextStyles.athleticStyle(
                  fontSize: 14,
                  fontFamily: AppTextStyles.sfPro700,
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: 1),
              Text(
                capitalizeEachWord(AppStrings.howItWorksDesc),
                overflow: TextOverflow.visible,
                style: AppTextStyles.getOpenSansGoogleFont(12, AppColors.whiteColor, false),
              ),
              SizedBox(height: 10,),
              Text(AppStrings.howToUnlock,style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),
              SizedBox(height: 1,),
              Text(
                overflow: TextOverflow.visible,
                capitalizeEachWord(  AppStrings.howToUnlockDesc),style: AppTextStyles.getOpenSansGoogleFont(12, AppColors.whiteColor, false),),
              AppImages.image(AppImages.playerB,width: double.infinity,fit: BoxFit.fill ),
              const SkillsGuideScreen(),
              SizedBox(height: 25,),
              AppImages.image(AppImages.howItGroup,width: double.infinity,fit: BoxFit.fill ),
              SizedBox(height: 15,),
              Text(AppStrings.howItStart,style: AppTextStyles.athleticStyle(fontSize: 12, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),
              Text(
                overflow: TextOverflow.visible,
                capitalizeEachWord(  AppStrings.howItStartDesc),style: AppTextStyles.getOpenSansGoogleFont(10, AppColors.whiteColor, false),),
              SizedBox(height: 20),
              AppImages.image(AppImages.teacher, ),
              SizedBox(height: 15,),
              Text(AppStrings.maximize,style: AppTextStyles.athleticStyle(fontSize: 12, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),
              Text(
                overflow: TextOverflow.visible,
                capitalizeEachWord( AppStrings.maximizeDesc),style: AppTextStyles.getOpenSansGoogleFont(10, AppColors.whiteColor, false),),

              SizedBox(height: 20),
              AppImages.image(AppImages.player, ),
              SizedBox(height: 15,),
              Text(AppStrings.masterTrain,style: AppTextStyles.athleticStyle(fontSize: 12, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),
              Text(
                overflow: TextOverflow.visible,
                capitalizeEachWord( AppStrings.masterTrainDesc),style: AppTextStyles.getOpenSansGoogleFont(10, AppColors.whiteColor, false),),
            ],
          ),
        ),
      ),
    );
  }
}
class SkillsGuideScreen extends StatelessWidget {
  const SkillsGuideScreen({super.key});

  final List<Map<String, dynamic>> steps = const [
    {
      "title": "Create Your Unique Player Profile",
      "points": [
        "Visit The QBounce Website and log in using your credentials.",
        "Fill in your details, including your name, jersey number, position, and skill level.",
        "Save your profile to personalize your training journey."
      ]
    },
    {
      "title": "Purchase the QBounce Skills Mat",
      "points": [
        "The QBounce Skills Mat is essential for accessing advanced drills and training.",
        "Each mat is designed to enhance your gameplay and measure your progress through interactive challenges."
      ]
    },
    {
      "title": "Locate The Verification Code",
      "points": [
        "Inside the package, you'll find a brochure with a unique verification code.",
        "This code is your key to unlocking exclusive drills and advanced levels on the QBounce App."
      ]
    },
    {
      "title": "Activate Your Account",
      "points": [
        "Open the QBounce App and enter the verification code during setup.",
        "This setup will grant access to a variety of skill-enhancing drills tailored to your level."
      ]
    },
    {
      "title": "Progress Through Levels",
      "points": [
        "Start with your current training level and complete drills to improve your stats.",
        "Unlock higher levels as you demonstrate precision, speed, and consistency.",
        "Each level offers new challenges and achievements to help you become an elite player."
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: steps.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Text(
              '${index + 1}. ${steps[index]["title"]}',
              style:AppTextStyles.athleticStyle(fontSize: 12, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor)
            ),
            const SizedBox(height: 5),

            // Bullet Points
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                steps[index]["points"].length,
                    (i) => Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                         Text(
                           textAlign: TextAlign.start,
                          "• ", // Bullet symbol
                          style:  AppTextStyles.getOpenSansGoogleFont(18, AppColors.whiteColor, false),
                        ),
                        Expanded(
                          child: Text(
                            steps[index]["points"][i],
                            style:  AppTextStyles.getOpenSansGoogleFont(10, AppColors.whiteColor, false),
                          ),
                        ),
                      ],
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}