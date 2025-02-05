import 'package:flutter/cupertino.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_text_style.dart';

class CommonButton extends StatefulWidget {
  final String title;
  final Color color;
  final double? vertical;
  final double? horizontal;

  const CommonButton({super.key, required this.title, required this.color,  this.vertical,  this.horizontal});

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:widget.vertical?? 12,horizontal:widget.horizontal?? 58),
      // width: double.infinity,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: widget.color,
      ),
      child: Center(child: Text(widget.title,style: AppTextStyles.athleticStyle(fontSize: 18, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),)),
    );
  }
}
