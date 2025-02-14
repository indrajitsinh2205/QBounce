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
  int? selectedIndex;
  String? currentVideoId;

  @override
  void initState() {
    super.initState();
    // Set the initial selected index based on widget.id
    int initialIndex = widget.data?.indexWhere((item) =>
    item.id == int.tryParse(widget.id ?? "-1")) ??
        -1;
    selectedIndex = initialIndex >= 0 ? initialIndex : 0;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 25.54),
      itemBuilder: (context, index) {
        final item = widget.data?[index];
        bool isSelected = selectedIndex == index;

        return InkWell(
          onTap: () {
            setState(() {
              selectedIndex = index;
              currentVideoId = item?.id.toString();
              widget.onRebuildParent?.call(item?.categoryName, currentVideoId.toString());

              if (widget.isUnlocked) {
                context.read<TrainingVideoBloc>().add(FetchTrainingVideo(currentVideoId!));
              }
            });
          },
          child: Container(
            padding: EdgeInsets.only(left: 25, top: 18.5, bottom: 18.5),
            decoration: BoxDecoration(
              color: isSelected && widget.isUnlocked
                  ? AppColors.appColor
                  : Colors.transparent,
              border: Border.all(
                color: isSelected && widget.isUnlocked
                    ? AppColors.appColor
                    : AppColors.whiteColor.withOpacity(0.5),
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
                  item?.title ?? '',
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
      itemCount: widget.data?.length ?? 0,
    );
  }
}
