import 'package:flutter/cupertino.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_text_style.dart';

class CommonButton extends StatefulWidget {
  final String title;

  const CommonButton({super.key, required this.title});

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.5),
      width: double.infinity,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.appColor,
      ),
      child: Center(child: Text(widget.title,style: AppTextStyles.athleticStyle(fontSize: 18, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),)),
    );
  }
}
