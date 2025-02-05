import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_bounce/common_widget/common_button.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_images.dart';
import 'package:q_bounce/constant/app_text_style.dart';

import '../../common_widget/common_tab_bar.dart';
import '../../constant/app_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin  {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 25),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // CommonTabBar(
            //   initialIndex: 0,
            //   tabTitles: ["Beginner", "Advanced", "Pro", "Master"],
            //   Box: true,
            //   controller: _tabController,
            // ),
            // SizedBox(
            //   width: double.infinity,
            //   height: 247.46, // Adjust height according to your design
            //   child: Stack(
            //     children: [
            //       // Background container
            //       Positioned(
            //         top: MediaQuery.of(context).size.height * 0.074,
            //         left: MediaQuery.of(context).size.width * 0.334,
            //         child: AppImages.image(
            //           AppImages.rank1Person,
            //           height: 120,
            //           fit: BoxFit.fitHeight,
            //         ),
            //       ),
            //       Positioned.fill(
            //         child: Container(
            //           height: 248,
            //           decoration: AppImages.background(AppImages.rank1, fit: BoxFit.fitHeight),
            //         ),
            //       ),
            //
            //     ],
            //   ),
            // ),
            _buildRankContainer(0,0.071,0.022,248,105,AppImages.rank1Person, AppImages.rank1,"Rupert Johnson",isCrowned: true),

            gridComponent(),
            videoComponent(),
           leaderBoard()
          ],
        ),
      ),
    );
  }
  Widget gridComponent (){
    List level =["Beginner", "Advanced", "Pro", "Master"];
    return  GridView.count(
      padding: EdgeInsets.only(top: 25,right: 20,left: 20),
      crossAxisCount: 2,
      crossAxisSpacing:26.0,
      mainAxisSpacing: 10.0,
      shrinkWrap: true,
      childAspectRatio:1.6,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(level.length, (index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.whiteColor)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 23),
                child: AppImages.image(AppImages.ballIcon,height: 30,width: 30),
              ),
              // SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Level $index",style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfUi700, color: AppColors.whiteColor),),
                  Text(level[index],style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfUi700, color: AppColors.whiteColor),)
                ],
              ),
              SizedBox(width: 10,),
            ],
          ),
        );
      },),
    );
  }
  Widget videoComponent(){
    List video =["Triple threat", "Pound", "Cross", ];

    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 25.54,right: 20,left: 20),
        itemBuilder: (context, index) {
      return Container(
        padding: EdgeInsets.only(left: 25,top: 18.5,bottom: 18.5),
        decoration: BoxDecoration(
          color: AppColors.appColor,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Text(video[index],style: AppTextStyles.athleticStyle(fontSize: 18, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),
      );
    }, separatorBuilder: (context, index) => SizedBox(height: 10,), itemCount: video.length);
  }
  Widget leaderBoard(){
    List score =["Overall", "Monthly", "Weekly", ];
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Column(
        children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.leaderBoard.toUpperCase(),style: AppTextStyles.athleticStyle(fontSize: 32, fontFamily: AppTextStyles.athletic, color: AppColors.whiteColor),),
              CommonButton(title: AppStrings.allScore, color: AppColors.appColor,horizontal: 18.5,vertical: 9.5,)
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
                    borderRadius: BorderRadius.circular(35)
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
          _buildRankContainer(0,0.071,0.022,248,105,AppImages.rank1Person, AppImages.rank1,"Rupert Johnson",isCrowned: true),
          _buildRankContainer(20,0.00,0.076,164,66,AppImages.rank3Person, AppImages.rank3, "Emily Brown"),
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
