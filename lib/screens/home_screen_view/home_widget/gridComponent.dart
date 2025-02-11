import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constant/app_color.dart';
import '../../../constant/app_images.dart';
import '../../../constant/app_text_style.dart';

class Gridcomponent extends StatefulWidget {
  final String selectedButton;
  const Gridcomponent({super.key, required this.selectedButton});

  @override
  State<Gridcomponent> createState() => _GridcomponentState();
}

class _GridcomponentState extends State<Gridcomponent> {

  List level = ["Beginner", "Advanced", "Pro", "Master"];

  @override
  Widget build(BuildContext context) {
    // Find the index of the selected level
    int selectedIndex = level.indexOf(widget.selectedButton);

    // Print the selected button and its index for debugging
    print("Selected Button: ${widget.selectedButton}, Index: $selectedIndex");

    return GridView.count(
      padding: EdgeInsets.only(top: 25, right: 20, left: 20),
      crossAxisCount: 2,
      crossAxisSpacing: 26.0,
      mainAxisSpacing: 10.0,
      shrinkWrap: true,
      childAspectRatio: 1.6,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(level.length, (index) {
        // Check if the current index is the selected index
        bool isSelected = selectedIndex == index;

        return Container(
          decoration: BoxDecoration(
            color: isSelected?AppColors.appColor:Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.whiteColor, width: 3)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 23),
                child: AppImages.image(AppImages.ballIcon, height: 30, width: 30),
              ),
              SizedBox(width: 4),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Level ${index +1}",style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfUi700, color: AppColors.whiteColor),),
                  Text(level[index],style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfUi700, color: AppColors.whiteColor),)
                ],
              ),
              SizedBox(width: 10),
            ],
          ),
        );
      }),
    );
  }
}
