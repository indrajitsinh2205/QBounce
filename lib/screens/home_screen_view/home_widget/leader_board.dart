import 'package:flutter/cupertino.dart';

import '../../../common_widget/common_button.dart';
import '../../../constant/app_color.dart';
import '../../../constant/app_images.dart';
import '../../../constant/app_strings.dart';
import '../../../constant/app_text_style.dart';

class LeaderBoard extends StatefulWidget {
  final bool? scoreBool;
   LeaderBoard({super.key, this.scoreBool=true});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  List score =["Overall", "Monthly", "Weekly", ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.leaderBoard.toUpperCase(),style: AppTextStyles.athleticStyle(fontSize: 32, fontFamily: AppTextStyles.athletic, color: AppColors.whiteColor),),
                SizedBox(width: 20,),
                widget.scoreBool==false?SizedBox():CommonButton(title: AppStrings.allScore, color: AppColors.appColor,horizontal: 12.0,vertical: 5.5,font: 18,)
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 25),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: 50,
            child: ListView.separated(
              // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                // padding: EdgeInsets.only(top: 25.54),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal:  25,/*vertical:  10*/),
                    decoration: BoxDecoration(
                        color:index==0?AppColors.appColor:AppColors.scoreUnselect,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Center(child: Text(score[index],style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),)),
                  );
                }, separatorBuilder: (context, index) => SizedBox(width: 10,), itemCount: score.length),
          ),
          SizedBox(height: 25,),
          Container(
            decoration: AppImages.background(AppImages.leaderBG),
            child: SizedBox(
              width: double.infinity,
              // height: 250, // Adjust height if needed
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      _buildRankContainer(20,0.00,0.076,164,66,AppImages.rank2Person, AppImages.rank2,"Ethan White", ),
                      _buildRankContainer(0,0.069,0.028,248,105,AppImages.rank1Person, AppImages.rank1,"Rupert Johnson",isCrowned: true),
                      _buildRankContainer(20,0.0001,0.082,164,66,AppImages.rank3Person, AppImages.rank3, "Emily Brown"),
                    ],
                  ),
                  // SizedBox(height: 0,)
                ],
              ),
            ),
          ),

          // Container(
          //   decoration: AppImages.background(AppImages.leaderBG),
          //   child: SizedBox(
          //     width: double.infinity,
          //     height: 247.46, // Adjust height according to your design
          //     child: Stack(
          //       children: [
          //         // Background container
          //         Positioned(
          //           top: MediaQuery.of(context).size.height * 0.074,
          //           left: MediaQuery.of(context).size.width * 0.334,
          //           child: AppImages.image(
          //             AppImages.rank1Person,
          //             height: 120,
          //             fit: BoxFit.fitHeight,
          //           ),
          //         ),
          //         Positioned.fill(
          //           child: Container(
          //             height: 248,
          //             decoration: AppImages.background(AppImages.rank1, fit: BoxFit.fitHeight),
          //           ),
          //         ),
          //
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
  Widget _buildRankContainer(double bottom,double top,double left ,double height , double logoHeight,String personImage, String rankBackground,String name,{bool isCrowned = false}) {
    return   SizedBox(
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

              child: AppImages.image(
                personImage,
                height: logoHeight,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned.fill(
              bottom: 25,
              child: Container(
                height: height,
                decoration: AppImages.background(rankBackground, fit: BoxFit.fitHeight),
              ),
            ),
            Positioned(
                bottom: isCrowned?MediaQuery.of(context).size.height*0.040:MediaQuery.of(context).size.height*0.036,
                right: isCrowned?MediaQuery.of(context).size.width*0.04:MediaQuery.of(context).size.width*0.07,
                child: Column(
                  children: [
                    Text("$name",style: AppTextStyles.athleticStyle(fontSize: 12, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor)),
                    Text("US 500 XP",style: AppTextStyles.athleticStyle(fontSize: 11, fontFamily: AppTextStyles.sfPro500, color: AppColors.whiteColor)),
                  ],
                ))
          ],
        ),
      ),
    );
  }

}
