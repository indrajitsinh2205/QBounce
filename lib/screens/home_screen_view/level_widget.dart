

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_bounce/constant/app_images.dart';
import 'package:q_bounce/screens/home_screen_view/home_widget/video_component.dart';
import 'package:q_bounce/screens/home_screen_view/home_widget/video_details_component.dart';
import 'package:video_player/video_player.dart';

import '../../constant/app_color.dart';
import '../../constant/app_text_style.dart';

class LevelScreen extends StatefulWidget {
  final String text ;
  final VideoPlayerController videoPlayerController;
  const LevelScreen({super.key, required this.text, required this.videoPlayerController});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
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
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(height: 30,),
          Container(
            color: Color(0xFF333333),
            child: Column(
              children: [
                Container(
                  color:Color(0xFFD74B16),
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 14),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.text,style: AppTextStyles.athleticStyle(fontSize: 18, fontFamily: AppTextStyles.sfUi700, color: AppColors.whiteColor),),
                      Text("#4",style: AppTextStyles.athleticStyle(fontSize: 18, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),

                    ],
                  ),
                ),
                Container(
                  color: Color(0xFF333333),
                  padding: EdgeInsets.only(left: 20,top: 10,bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFFD74B16),width: 2)
                        ),
                        child:
                        AppImages.image(AppImages.ballImage,height: 75,width: 75)
                        // Image.asset("assets/ball.png",height: 75,width: 75,),
                      ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Michael Johnson",style: AppTextStyles.athleticStyle(fontSize: 18, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),
                          Row(
                            children: List.generate(5, (index) => Icon(Icons.star, color: Colors.yellow)),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
                Divider(
                  color: Color(0xFFD74B16),
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space between items
                    children: [

                      for (var item in stateData)
                        Container(
                          // height: 33,
                          padding: EdgeInsets.symmetric(vertical: 19.27), // Optional padding inside each item
                          child: Container(
                            height: 56.46,
                            width: 52.45,
                            decoration: AppImages.background(AppImages.levelFrame),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  item['name']!,
                                  style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  item['point']!,
                                  style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: 	FontWeight.w700),
                                ),
                                SizedBox(height: 2,)
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          VideoComponent(),
          VideoDetailsComponent(videoPlayerController: widget.videoPlayerController,)
        ],
      ),
    );
  }
}
