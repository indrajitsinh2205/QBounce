import 'package:flutter/material.dart';

import '../../common_widget/common_button.dart';
import '../../common_widget/common_text_field.dart';
import '../../constant/app_color.dart';
import '../../constant/app_strings.dart';
import '../../constant/app_text_style.dart';

  class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _staticMailController = TextEditingController();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _uMailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _STLController = TextEditingController();
  final TextEditingController _BLKController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.contactUs.toUpperCase(),style: AppTextStyles.athleticStyle(fontSize: 32, fontFamily: AppTextStyles.athletic, color: AppColors.whiteColor),),
            SizedBox(height: 10,),
            Text(AppStrings.contactUsDesc,style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro400, color: AppColors.whiteColor),),
            // SizedBox(height: 25,),
            dataFormWidget()
          ],
        ),
      ),
    );
  }
  Widget dataFormWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          CommonTextField(icon: Icon(Icons.mail_outline_outlined) ,controller: _staticMailController,hint:  AppStrings.staticMail, label: '',boarder: true,),
          SizedBox(height: 30),
          Row(
            children: [
              Flexible(
                  child: CommonTextField(controller: _fNameController,label:  AppStrings.fName,hint:  AppStrings.fName,),
              ),
              SizedBox(width: 10),
              Flexible(
                child: CommonTextField(controller: _lNameController,label:  AppStrings.lName,hint:  AppStrings.lName,),
              ),

            ],
          ),
          SizedBox(height: 15),
          CommonTextField(controller: _uMailController,label:  AppStrings.uMail,hint:  AppStrings.uMail,),
          SizedBox(height: 15),
          CommonTextField(controller: _messageController,label:  AppStrings.message,hint:  AppStrings.message,),
          SizedBox(height: 15),
          Row(
            children: [
              CommonButton(title: AppStrings.save,color: AppColors.appColor,),
            ],
          )        ],
      ),
    );
  }

}
