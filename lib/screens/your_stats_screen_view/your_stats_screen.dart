import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:q_bounce/common_widget/common_button.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_images.dart';
import 'package:q_bounce/constant/app_strings.dart';

import '../../constant/app_text_style.dart';

class YourStatsScreen extends StatefulWidget {
  const YourStatsScreen({super.key});

  @override
  State<YourStatsScreen> createState() => _YourStatsScreenState();
}

class _YourStatsScreenState extends State<YourStatsScreen> {
  List<Map<String, String>> stateData =[
    {"name":"PTS",
      "point":"1",
    },
    {"name":"RED",
      "point":"1",
    },
    {"name":"AST",
      "point":"3",
    },
    {"name":"STL",
      "point":"4",
    },
    {"name":"BLK",
      "point":"5",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(AppStrings.yourState.toUpperCase(),style: AppTextStyles.athleticStyle(fontSize: 28, fontFamily: AppTextStyles.athletic, color: AppColors.whiteColor)),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 8,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Slidable(
                    startActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        // SlidableAction(
                        //   onPressed: (BuildContext context) {
                        //     // Handle edit action
                        //     print('Edit ${stateData[index]['name']}');
                        //   },
                        //   backgroundColor: Colors.blue,
                        //   foregroundColor: Colors.white,
                        //   icon: Icons.edit,
                        //   label: 'Edit',
                        // ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        InkWell(
                          onTap: () => _showAlertDialog(context),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 6),
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFD74B16),
                            ),
                            child: AppImages.image(AppImages.delete,height: 35,width: 35,fit: BoxFit.fitWidth)
                            // Image.asset(
                            //   "assets/delete.png",
                            //   height: 35,
                            //   width: 35,
                            //   fit: BoxFit.fitWidth,
                            // ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFFD31D0B),
                          ),
                          child: AppImages.image(AppImages.edit,height: 35,width: 35,fit: BoxFit.fitWidth)
                        ),
                      ],
                    ),

                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(image: AssetImage("assets/images/stateBG.png"),fit: BoxFit.cover)
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppImages.image(AppImages.ballImage,height: 30,width: 30,),
                              // Image.asset("assets/ball.png",height: 30,width: 30,),
                              SizedBox(width: 5,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("US@Dfs",style: TextStyle(fontSize: 22,color: AppColors.whiteColor,fontWeight: FontWeight.w600),),
                                  Text("07-01-25",style: TextStyle(fontSize: 13,color:AppColors.whiteColor.withOpacity(0.5),fontWeight: FontWeight.w400),)
                                ],
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            height: 2,  // Height of the divider
                            width: double.infinity,  // Full width
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFD74B16), Color(0xFFE9B6A3)],  // Gradient colors
                                begin: Alignment. center,
                                end: Alignment.center,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space between items
                            children: [

                              for (var item in stateData)
                                Container(
                                  // height: 33,
                                  padding: EdgeInsets.symmetric(horizontal: 8.0), // Optional padding inside each item
                                  child: Column(
                                    children: [
                                      Text(
                                        item['name']!,
                                        style: TextStyle(fontSize: 10, color: AppColors.whiteColor, fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        item['point']!,
                                        style: TextStyle(fontSize: 14, color: AppColors.whiteColor, fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                );
              },)
          ],
        ),
      ),
    );
  }
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.alertColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          title: Center(
            child: AppImages.image(
              AppImages.confirmDelete,
              height: 78,
              width: 80,
              fit: BoxFit.fitWidth,
            ),
          ),
          content: SizedBox(
            width: 300, // Set a fixed width for the dialog
            child: Column(
              mainAxisSize: MainAxisSize.min, // Prevent infinite height
              children: [
                Text(
                  AppStrings.areYouSure,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.athleticStyle(
                    fontSize: 24,
                    fontFamily: AppTextStyles.sfPro700,
                    color: AppColors.whiteColor,
                  ),
                ),
                SizedBox(height: 8), // Add spacing
                Text(
                  AppStrings.alertDesc,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.getOpenSansBoldGoogleFont(
                    18, AppColors.whiteColor, false,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute buttons evenly
              children: [
                CommonButton(title: AppStrings.cancel, color: AppColors.faq,horizontal: 10,font: 14,),
                SizedBox(width: 10,),
                CommonButton(title: AppStrings.yesDelete, color: AppColors.appColor,horizontal: 10,font: 14,),
              ],
            ),
          ],
        );
      },
    );
  }

}
