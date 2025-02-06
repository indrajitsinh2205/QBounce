import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_bounce/constant/app_images.dart';

import '../../../constant/app_color.dart';
import '../../../constant/app_text_style.dart';

class VideoComponent extends StatefulWidget {
  const VideoComponent({super.key});

  @override
  State<VideoComponent> createState() => _VideoComponentState();
}

class _VideoComponentState extends State<VideoComponent> {
  List video =["Triple threat", "Pound", "Cross", ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 25.54,/*right: 20,left: 20*/),
        itemBuilder: (context, index) {
          print(video[0]);
          return Container(
            padding: EdgeInsets.only(left: 25,top: 18.5,bottom: 18.5),
            decoration: BoxDecoration(
                color: index==0?AppColors.appColor:Colors.transparent,
                border: Border.all(color: index==0?Colors.transparent:AppColors.whiteColor.withOpacity(0.5),width: 2),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              children: [
                if(index!=0)Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: AppImages.image(AppImages.lock,height: 20,width: 20),
                ),
                Text(video[index],style: AppTextStyles.athleticStyle(fontSize: 18, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),
              ],
            ),
          );
        }, separatorBuilder: (context, index) => SizedBox(height: 10,), itemCount: video.length);
  }
}
