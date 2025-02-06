import 'package:flutter/material.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_text_style.dart';
import 'package:q_bounce/screens/home_screen_view/home_widget/leader_board.dart';

import '../constant/app_images.dart';

class StaticLeaderBoard extends StatefulWidget {
  const StaticLeaderBoard({super.key});

  @override
  State<StaticLeaderBoard> createState() => _StaticLeaderBoardState();
}

class _StaticLeaderBoardState extends State<StaticLeaderBoard> {
  static List<Map<String, dynamic>> userData = [
    {
      "no": 4,
      "title": "Michael Johnson",
      "content": "US",
      "image": AppImages.rank1Person,
    },
    {
      "no": 5,
      "title": "Sophia Miller",
      "content": "US",
      "image": AppImages.rank2Person,
    },
    {
      "no": 6,
      "title": "William Anderson",
      "content": "US",
      "image": AppImages.rank3Person,
    },
    {
      "no": 7,
      "title": "Michael Johnson",
      "content": "US",
      "image": AppImages.rank1Person,
    },
    {
      "no": 8,
      "title": "Sophia Miller",
      "content": "US",
      "image": AppImages.rank2Person,
    },
    {
      "no": 9,
      "title": "William Anderson",
      "content": "US",
      "image": AppImages.rank3Person,
    },

  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
        LeaderBoard(scoreBool: false,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
            child: userList(),
          ),
        ],
      ),
    );
  }
  Widget userList(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: userData.length,
      physics: NeverScrollableScrollPhysics(
      ),
      itemBuilder: (context, index) {
        var data = userData[index];
      return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
        decoration: BoxDecoration(
          color: AppColors.alertColor,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 21,vertical: 10),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 23,
                  child: Text(data['no'].toString(),style: AppTextStyles.athleticStyle(fontSize: 12, fontFamily: AppTextStyles.sfPro500, color: AppColors.whiteColor),)),


              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                child: AppImages.image(data['image'],height: 32,width: 32),
              ),
              SizedBox(width: 10,),
              Expanded(child: Text(textAlign: TextAlign.start,data['title'],style: AppTextStyles.athleticStyle(fontSize: 12, fontFamily: AppTextStyles.sfPro500, color: AppColors.whiteColor),)),

              Row(
                children: [
                  Text(data['content'],style: AppTextStyles.athleticStyle(fontSize: 12, fontFamily: AppTextStyles.sfPro500, color: AppColors.whiteColor),),
                  SizedBox(width: 15,),
                  Text('500 XP',style: AppTextStyles.athleticStyle(fontSize: 12, fontFamily: AppTextStyles.sfPro500, color: AppColors.whiteColor),),

                ],
              )
               ],
          ),
        ),
      );
    },);
  }
}
