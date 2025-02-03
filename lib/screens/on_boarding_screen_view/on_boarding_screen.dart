import 'package:flutter/material.dart';
import 'package:q_bounce/app_services/navigation_service.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_images.dart';
import 'package:q_bounce/constant/app_strings.dart';
import 'package:q_bounce/constant/app_text_style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView
          PageView(
            controller: _pageController,
            children: const [
              OnboardingSlide(imagePath: AppImages.landing1),
              OnboardingSlide(imagePath: AppImages.landing2,subText: AppStrings.landing2,),
              OnboardingSlide(imagePath: AppImages.landing3,subText: AppStrings.landing2,),
            ],
          ),
          // SmoothPageIndicator
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: WormEffect(
                  dotColor: AppColors.whiteColor.withOpacity(0.4),
                  activeDotColor: AppColors.whiteColor.withOpacity(0.4),
                  dotHeight: 12,
                  dotWidth: 12,
                ),
              ),
            ),
          ),
          // "Get Started" Button
          Positioned(
            bottom: 40,
            left: 32,
            right: 32,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                if (_pageController.page == 2) {
                  print("object");
                  NavigationService.navigateTo(NavigationService.signIn);
                  // Navigate to home or any other screen when on the last page
                  // Navigator.pushReplacementNamed(context, '/home');
                } else {
                  // Move to the next page
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },

              child:  Text(
                "GET STARTED →",
                style: AppTextStyles.athleticStyle(
                    fontSize: 18,
                    fontFamily: AppTextStyles.sfPro700,
                    color: AppColors.whiteColor,

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class OnboardingSlide extends StatelessWidget {
  final String imagePath;
  final String? subText;

  const OnboardingSlide({super.key, required this.imagePath, this.subText});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand, // Ensures the image covers the entire screen
      children: [
        AppImages.image(imagePath),
        Positioned(
            top: 68,
          left:MediaQuery.of(context).size.width / 2 - 100,
            child:AppImages.image(AppImages.logo,width: 200),
        ),
        Positioned(
          bottom: 140, // Adjust position as needed
          left: 20, // Adjust alignment
          right: 20,
          child: Text(
             subText!=null? subText.toString().toUpperCase():'',
            textAlign: TextAlign.start,
            style: AppTextStyles.athleticStyle(
              fontSize: 25,
              fontFamily: AppTextStyles.athletic,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
