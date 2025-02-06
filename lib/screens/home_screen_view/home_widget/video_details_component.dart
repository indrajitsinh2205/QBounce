import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../app_services/common_Capital.dart';
import '../../../constant/app_color.dart';
import '../../../constant/app_text_style.dart';

class VideoDetailsComponent extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  const VideoDetailsComponent({super.key, required this.videoPlayerController});

  @override
  State<VideoDetailsComponent> createState() => _VideoDetailsComponentState();
}

class _VideoDetailsComponentState extends State<VideoDetailsComponent> {
  final List<Map<String, dynamic>> videoDetails  = [
    {
      "title": "Instructions :",
      "points": [
        "Repeat drills for 15 sec",
        "Rest 15 sec between rounds",
        "Choose your own tempo"
      ]
    },
{
"title": "Don’t forget:",
"points": [
"QBounce Master Training mat lines are a guide for understanding and learning drills. Focus on executing the correct move no matter the tempo."
]
},
{
"title": "Extra Tip:",
"points": [
"Once you get a hang of the exercise try to lift your head and glance at the ball as little as possible."
]
},
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 0,vertical: 20),
    child: Column(
      children: [
    widget.videoPlayerController.value.isInitialized
    ? Stack(
      children:[ 
        AspectRatio(
      aspectRatio: widget.videoPlayerController.value.aspectRatio,
        child: VideoPlayer(widget.videoPlayerController),
      ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.transparent,
              border: Border.all(color: Colors.white)
            ),
            child: IconButton(onPressed: () {
              setState(() {
                widget.videoPlayerController.value.isPlaying
                    ? widget.videoPlayerController.pause()
                    : widget.videoPlayerController.play();
              });
            }, icon: Icon(widget.videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,)),
          ),
        )
      ]
    )
            : Container(),
      SizedBox(height: 25,),

      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal:  25,vertical:  18.5),
        decoration: BoxDecoration(
            color: AppColors.appColor,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text("Triple threat",style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),
            Text("1/3",style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),
          ],
        ),
      ),
      SizedBox(height: 15,),
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal:  25,vertical:  18.5),
        decoration: BoxDecoration(
            color: AppColors.faq,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("XP Reward Points",style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),
            Text("100",style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),

          ],
        ),
      ),
        detailsComponent()
      ],
    ),
    );
  }

  Widget detailsComponent (){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.all( 20),
      decoration: BoxDecoration(
        color: AppColors.faq,
        borderRadius: BorderRadius.circular(8)
      ),
      child: ListView.builder(
        itemCount: videoDetails.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 15),
              Text(CommonCapital.capitalizeEachWord(
                  '${index + 1}. ${videoDetails[index]["title"]}'),
                  style:AppTextStyles.athleticStyle(fontSize: 12, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor)
              ),
              const SizedBox(height: 5),
      
              // Bullet Points
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  videoDetails[index]["points"].length,
                      (i) => Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        "• ", // Bullet symbol
                        style:  AppTextStyles.getOpenSansGoogleFont(18, AppColors.whiteColor, false),
                      ),
                      Expanded(
                        child: Text(
                          CommonCapital.capitalizeEachWord(
                          videoDetails[index]["points"][i]),
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
      ),
    );
  }
}
