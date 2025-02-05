import 'package:flutter/material.dart';
import 'package:q_bounce/constant/app_images.dart';
import 'package:q_bounce/screens/how_to_cast_screen_view/cast_Data.dart';

import '../../constant/app_color.dart';
import '../../constant/app_strings.dart';
import '../../constant/app_text_style.dart';

class HowToCastScreen extends StatefulWidget {
  const HowToCastScreen({super.key});

  @override
  State<HowToCastScreen> createState() => _HowToCastScreenState();
}

class _HowToCastScreenState extends State<HowToCastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.howToCast.toUpperCase(),style: AppTextStyles.athleticStyle(fontSize: 32, fontFamily: AppTextStyles.athletic, color: AppColors.whiteColor),),
            // Text(AppStrings.howToUse2,style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro400, color: AppColors.whiteColor),),
            SizedBox(height: 10,),
        
            castData()
          ],
        ),
      ),
    );
    
  }
  Widget castData() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: CastDataList.castList.length,
      separatorBuilder: (context, index) => SizedBox(height: 25),
      itemBuilder: (context, index) {
        var cast = CastDataList.castList[index];

        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Background Image
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  width: double.infinity,
                  decoration: AppImages.background(AppImages.castBack),
                  child: Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.whiteColor,width: 3),
                        borderRadius: BorderRadius.circular(12),

                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical:  15, horizontal: 10.5),
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: AppImages.image(cast['image'],width:double.infinity,height: 100,)
                            ),
                            SizedBox(height: 15),
                            Text(cast['title'].toString(),style: AppTextStyles.athleticStyle(fontSize: 12, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),
                            SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                cast["content"].length,
                                    (i) => Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "• ", // Bullet symbol
                                        style: AppTextStyles.getOpenSansGoogleFont(
                                          18,
                                          AppColors.whiteColor,
                                          false,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          cast["content"][i],
                                          style: AppTextStyles.getOpenSansGoogleFont(
                                            10, // Increased font size for readability
                                            AppColors.whiteColor,
                                            false,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Floating Step Number (Fixes Alignment)
              Positioned(
                  left: (index % 2 == 0) ? 2 : null,
                  right: (index % 2 != 0) ? 2 : null,
                  child: Container(decoration: AppImages.background(AppImages.castLogo,),
                    height: 50,width: 45,
                    child: Center(child: Text(cast['step'].toString(),style: AppTextStyles.athleticStyle(fontSize: 25, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),)),
                  )),
            ],
          ),
        );
      },
    );
  }
}
