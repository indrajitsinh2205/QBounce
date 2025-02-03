import 'package:flutter/material.dart';

import '../constant/app_color.dart';
import '../constant/app_images.dart';
import '../constant/app_strings.dart';
import '../constant/app_text_style.dart';
import '../screens/faq_screen_view/faq_screen.dart';
import '../screens/how_to_use_screen_view/how_to_use_screen.dart';
import '../screens/privacy_policy_screen_view/privacy_policy_screen.dart';
import '../screens/terms_and_conditons_screen_view/terms_and_conditons_screen.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget actions;

  CommonAppBar({
    required this.title,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent ,
      title: actions,
      leading: IconButton(
        icon: Icon(Icons.menu,color: Colors.white,),
        onPressed: () {
          Scaffold.of(context).openDrawer(); // Open the drawer when the menu icon is tapped
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  Widget _selectedScreen = HowToUseScreen(); // Default screen

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppImages.background(AppImages.appBackGround),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CommonAppBar(
          title: '',
          actions:   AppImages.image(AppImages.logo,width: 220),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('How To Use'),
                onTap: () {
                  setState(() {
                    _selectedScreen = HowToUseScreen();
                  });
                  Navigator.pop(context); // Close drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text('FAQ'),
                onTap: () {
                  setState(() {
                    _selectedScreen = FAQPage();
                  });
                  Navigator.pop(context); // Close drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text('Privacy'),
                onTap: () {
                  setState(() {
                    _selectedScreen = PrivacyPolicyScreen();
                  });
                  Navigator.pop(context); // Close drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.terminal_sharp),
                title: Text('Terms & Conditions'),
                onTap: () {
                  setState(() {
                    _selectedScreen = TermsAndConditonsScreen();
                  });
                  Navigator.pop(context); // Close drawer
                },
              ),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,),
          child: _selectedScreen, // Dynamically changing screen content
        ),
      ),
    );
  }
}

// HowToUseScreen Content (Separate widget)
class HowToUseScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.heyThere.toUpperCase(),
            style: AppTextStyles.athleticStyle(
                fontSize: 32,
                fontFamily: AppTextStyles.athletic,
                color: AppColors.whiteColor),
          ),
          Text(
            AppStrings.howToUse1,
            style: AppTextStyles.athleticStyle(
                fontSize: 14,
                fontFamily: AppTextStyles.sfPro400,
                color: AppColors.whiteColor),
          ),
          SizedBox(height: 25),
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
            AppStrings.howItWorksDesc,
            overflow: TextOverflow.visible,
            style: AppTextStyles.getOpenSansGoogleFont(12, AppColors.whiteColor, false),
          ),
          SizedBox(height: 20),
          AppImages.image(AppImages.teacher),
          SizedBox(height: 15),
          Text(
            AppStrings.masterTrain,
            style: AppTextStyles.athleticStyle(
                fontSize: 12,
                fontFamily: AppTextStyles.sfPro700,
                color: AppColors.whiteColor),
          ),
          Text(
            AppStrings.masterTrainDesc,
            overflow: TextOverflow.visible,
            style: AppTextStyles.getOpenSansGoogleFont(10, AppColors.whiteColor, false),
          ),
        ],
      ),
    );
  }
}

// FAQ Screen Content (Separate widget)
