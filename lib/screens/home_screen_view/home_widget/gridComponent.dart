import 'package:flutter/cupertino.dart';

import '../../../constant/app_color.dart';
import '../../../constant/app_images.dart';
import '../../../constant/app_text_style.dart';

class Gridcomponent extends StatefulWidget {
  const Gridcomponent({super.key});

  @override
  State<Gridcomponent> createState() => _GridcomponentState();
}

class _GridcomponentState extends State<Gridcomponent> {
  List level =["Beginner", "Advanced", "Pro", "Master"];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
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
}
