import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common_widget/common_button.dart';
import '../../../constant/app_color.dart';
import '../../../constant/app_images.dart';
import '../../../constant/app_strings.dart';
import '../../../constant/app_text_style.dart';

class LeaderBoard extends StatefulWidget {
  final bool? scoreBool;
  final Function(String)? onLevelSelected;
  final double? padding;


  LeaderBoard({super.key, this.scoreBool = true, this.onLevelSelected, this.padding});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  int selectedIndex = 0; // Default selected index
  List<String> score = ["Overall", "Monthly", "Weekly"];
  List<String> scoreData = ["overall", "month", "week"];

  @override
  Widget build(BuildContext context) {
    widget.onLevelSelected?.call(scoreData[0]);
    return Padding(
      padding:  EdgeInsets.only(top:widget.padding?.toDouble() ?? 25.0),
      child: Column(
        children: [
          // Existing code...

          Container(
            margin: EdgeInsets.only(top: 25),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(score.length, (index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });

                    // Trigger the callback and pass the selected level (score)
                    widget.onLevelSelected?.call(scoreData[selectedIndex]);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: index == selectedIndex
                          ? AppColors.appColor
                          : AppColors.scoreUnselect,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        score[index],
                        style: AppTextStyles.athleticStyle(
                          fontSize: 14,
                          fontFamily: AppTextStyles.sfPro700,
                          color: index == selectedIndex
                              ? AppColors.blackColor
                              : AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          // Existing code...
        ],
      ),
    );
  }
}


