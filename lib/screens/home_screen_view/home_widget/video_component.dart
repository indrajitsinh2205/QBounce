import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/constant/app_images.dart';

import '../../../constant/app_color.dart';
import '../../../constant/app_text_style.dart';
import '../../training_screen_view/training_bloc/training_program_bloc.dart';
import '../../training_screen_view/training_bloc/training_program_event.dart';
import '../../training_screen_view/training_program_bloc/training_program_bloc.dart';
import '../../training_screen_view/training_program_bloc/training_program_event.dart';

class VideoComponent extends StatefulWidget {
  final List<dynamic>? data;
  final bool isUnlocked;
  final bool? padding;
  final String text;
  final String? id;
  final void Function(String id, String text)? onRebuildParent;

  const VideoComponent({
    super.key,
    this.data,
    required this.isUnlocked,
    this.padding, required this.text,  this.onRebuildParent, this.id,
  });

  @override
  State<VideoComponent> createState() => _VideoComponentState();
}

class _VideoComponentState extends State<VideoComponent> {
  int? selectedIndex =0; // To track the selected item index
  String? currentVideoId;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 25.54),
      itemBuilder: (context, index) {
        // Assuming widget.data is a List<Unlocked>
        final item = widget.data?[index];
        if (widget.data != null) {
          for (int i = 0; i < widget.data!.length; i++) {
            print('Index $i: id = ${widget.data![i].id}');
          }
        } else {
          print('No data available');
        }

        int selectedIndexData = widget.data?.indexWhere((item) =>
        item.id == int.parse(widget.id ?? "-1")
        ) ?? -1;

        print("selectedIndexData $selectedIndexData");
        print("widgetId ${widget.id}");
        print("widget.data?.toList() ${widget.data?.toList().toString()}");

        bool isSelected = widget.id == null ? selectedIndex == index : selectedIndexData == index;
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   setState(() {
        //     widget.id == null ? selectedIndex = index : selectedIndex = selectedIndexData;
        //   });
        // });

        return InkWell(
            onTap: () {
              setState(() {
                print("selected index: $index");
                print("widget text: ${widget.text}");

                // Update selected index
                selectedIndex = index;

                // Update currentVideoId and call the parent callback if provided
                 currentVideoId = item.id.toString();
                widget.onRebuildParent?.call(item.categoryName, item.id.toString());

                widget.onRebuildParent != null
                    ?  currentVideoId
                    :  currentVideoId;
                print(widget.onRebuildParent != null
                    ?  "currentVideoId $currentVideoId"
                    :  "currentVideoId $currentVideoId");
              });

              // Proceed only if the video is unlocked
              if (widget.isUnlocked) {
                // Dispatch the event with the updated ID
                print("currentVideoIdData$currentVideoId");
                context.read<TrainingVideoBloc>().add(FetchTrainingVideo(currentVideoId.toString()));
              }
            },
          child: Container(
            padding: EdgeInsets.only(left: 25, top: 18.5, bottom: 18.5),
            decoration: BoxDecoration(
              color:isSelected && widget.isUnlocked
                  ? AppColors.appColor  // Set background color when item is selected
                  : widget.isUnlocked
                  ? Colors.transparent  // Background color for unlocked items
                  : Colors.transparent,  // Transparent for locked items
              border: Border.all(
                color: isSelected && widget.isUnlocked
                    ? AppColors.appColor // Border color when selected
                    : widget.isUnlocked
                    ? AppColors.whiteColor.withOpacity(0.5)
                    : AppColors.whiteColor.withOpacity(0.5), // Border for locked items
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                if (!widget.isUnlocked)
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: AppImages.image(AppImages.lock, height: 20, width: 20),
                  ),
                Text(
                  item.title,
                  style: AppTextStyles.athleticStyle(
                    fontSize: 18,
                    fontFamily: AppTextStyles.sfPro700,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemCount: widget.data!.length,
    );
  }
}
