import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_color.dart';
import '../../../constant/app_images.dart';
import '../../../constant/app_text_style.dart';

class BuildRankContainer extends StatelessWidget {
  final double bottom;
      final double top;
  final double left ;
      final double height ;
  final double logoHeight;
      final String personImage;
  final String rankBackground;
      final String name;
 final  bool? isCrowned ;
 final  String point ;
   BuildRankContainer({super.key, required this.bottom, required this.top, required this.left, required this.height, required this.logoHeight, required this.personImage, required this.rankBackground, required this.name, this.isCrowned, required this.point});

  @override
  Widget build(BuildContext context) {
    print("personImage : $personImage");
    return  SizedBox(
      width: MediaQuery.of(context).size.width/3,
      height: height, // Adjust height according to your design
      child: Padding(
        padding:  EdgeInsets.only(bottom: bottom),
        child: Stack(
          children: [
            // Background container
            Positioned(
              // top: MediaQuery.of(context).size.height * 0.074,
              // left: MediaQuery.of(context).size.width * 3,
              top: MediaQuery.of(context).size.height * top,
              left: MediaQuery.of(context).size.width * left,

              child:personImage ==null  || personImage.isEmpty? Container(
                height: logoHeight,
                width: logoHeight, // Ensure the container is square
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(logoHeight / 2), // Make it round based on height
                  image: DecorationImage(
                    image: AssetImage("assets/images/placeholder.jpg"),
                    fit: BoxFit.cover, // Ensure the image covers the area
                  ),
                ),
                child: ClipOval( // Ensures the child image is round
                  child: Image.asset(
                    "assets/images/placeholder.jpg",
                    height: logoHeight,
                    width: logoHeight,
                    fit: BoxFit.cover, // Ensures the image fills the circular space
                  ),
                ),
              ): Container(
                height: logoHeight,
                width: logoHeight, // Ensure the container is square
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(logoHeight / 2), // Make it round based on height
                  image: DecorationImage(
                    image: NetworkImage(personImage),
                    fit: BoxFit.cover, // Ensure the image covers the area
                  ),
                ),
                child: ClipOval( // Ensures the child image is round
                  child: Image.network(
                    personImage,
                    height: logoHeight,
                    width: logoHeight,
                    fit: BoxFit.cover, // Ensures the image fills the circular space
                  ),
                ),
              ),

            ),
            Positioned.fill(
              bottom: 25,
              child: Container(
                height: height,
                decoration: AppImages.background(rankBackground, fit: BoxFit.fitHeight,),
              ),
            ),
            Positioned(
                bottom: isCrowned==true?MediaQuery.of(context).size.height*0.040:MediaQuery.of(context).size.height*0.036,
                right: isCrowned==true?MediaQuery.of(context).size.width*0.03:MediaQuery.of(context).size.width*0.055,
                child: Column(
                  children: [
                    Container(
                        width:isCrowned==true?100:80,
                        alignment: Alignment.center,
                        child: Text(
                            overflow: TextOverflow.ellipsis,
                            "$name",style: AppTextStyles.athleticStyle(fontSize: 12, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor))),
                    Text("US $point XP",style: AppTextStyles.athleticStyle(fontSize: 11, fontFamily: AppTextStyles.sfPro500, color: AppColors.whiteColor)),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
