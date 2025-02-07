import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_text_style.dart';

class CommonTextField extends StatefulWidget {
  final bool? boarder;
  final bool? textArea;
  final bool? readOnly;
  final Widget? icon;
  final bool? hintColor;
  final TextEditingController controller;
    final  String? label;
  final String hint;
      final bool? numType;
  const CommonTextField({super.key, required this.controller, required this.label, required this.hint, this.numType, this.boarder = false, this.icon, this.textArea = false, this.readOnly = false, this.hintColor = false});

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label.toString(), style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor)),
        SizedBox(height: 10),
        Container(
          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white),
          child:TextField(
            keyboardAppearance: Brightness.dark,
            cursorColor: AppColors.appColor,
            readOnly:widget.readOnly as bool ,
            maxLines:widget.textArea==true?4: 1,
            keyboardType: widget.numType == true ? TextInputType.number : TextInputType.name,
            controller: widget.controller,style: AppTextStyles.getOpenSansGoogleFont(13, AppColors.whiteColor, false),
            decoration: InputDecoration(
              prefixIcon: widget.icon??null,
              prefixIconColor: AppColors.whiteColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(width: 1, color: widget.boarder==false?Colors.transparent:AppColors.whiteColor.withOpacity(0.5)),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(width: 1, color: widget.boarder==false?Colors.transparent:AppColors.whiteColor.withOpacity(0.5)),
              ),
              focusedBorder: OutlineInputBorder( // Ensures border stays the same when focused
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(width: 1, color: widget.boarder==false?Colors.transparent:AppColors.whiteColor.withOpacity(0.5)),
              ),
              // errorBorder: OutlineInputBorder( // Keeps same border in error state
              //   borderRadius: BorderRadius.circular(12),
              //   borderSide: BorderSide(width: 1, color: AppColors.whiteColor),
              // ),
              // focusedErrorBorder: OutlineInputBorder( // Keeps same border when error + focused
              //   borderRadius: BorderRadius.circular(12),
              //   borderSide: BorderSide(width: 1, color: AppColors.whiteColor),
              // ),
              fillColor: AppColors.faq,
              filled: true,
              hintText: widget.hint,
              hintStyle:widget.label!.isEmpty? AppTextStyles.athleticStyle(fontSize: 16, fontFamily: AppTextStyles.sfPro500, color:widget.hintColor==true?AppColors.whiteColor.withOpacity(0.5): AppColors.whiteColor)
        : AppTextStyles.getOpenSansGoogleFont(12, AppColors.whiteColor.withOpacity(0.5), false),
            ),
          ),

        ),
      ],
    );
  }
}
