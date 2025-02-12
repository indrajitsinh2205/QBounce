import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/app_services/common_Capital.dart';
import '../../../constant/app_color.dart';
import '../../../constant/app_images.dart';
import '../../../constant/app_text_style.dart';
import '../../training_screen_view/training_program_bloc/training_program_bloc.dart';
import '../../training_screen_view/training_program_bloc/training_program_event.dart';

class Gridcomponent extends StatefulWidget {
  final String selectedButton;
  const Gridcomponent({super.key, required this.selectedButton});

  @override
  State<Gridcomponent> createState() => _GridcomponentState();
}

class _GridcomponentState extends State<Gridcomponent> {
  List<String> level = ["beginner", "advanced", "pro", "master"];
  int selectedIndex = 0; // Initially selected first item

  @override
  void initState() {
    super.initState();
    // Set initial selection based on widget.selectedButton
    int index = level.indexOf(widget.selectedButton);
    if (index != -1) {
      selectedIndex = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.only(top: 25, right: 20, left: 20),
      crossAxisCount: 2,
      crossAxisSpacing: 26.0,
      mainAxisSpacing: 10.0,
      shrinkWrap: true,
      childAspectRatio: 1.6,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(level.length, (index) {
        bool isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            context.read<TrainingProgramBloc>().add(FetchTraining(level[index]));

            print("Selected Level: ${level[index]}");
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColors.appColor : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.whiteColor, width: 3),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 23),
                  child: AppImages.image(AppImages.ballIcon, height: 30, width: 30),
                ),
                const SizedBox(width: 4),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Level ${index + 1}",
                      style: AppTextStyles.athleticStyle(
                          fontSize: 14,
                          fontFamily: AppTextStyles.sfUi700,
                          color: AppColors.whiteColor),
                    ),
                    Text(
                      CommonCapital.capitalizeEachWord(level[index])
                      ,
                      style: AppTextStyles.athleticStyle(
                          fontSize: 14,
                          fontFamily: AppTextStyles.sfUi700,
                          color: AppColors.whiteColor),
                    )
                  ],
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        );
      }),
    );
  }
}
