import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common_widget/common_text_field.dart';
import '../../constant/app_color.dart';
import '../../constant/app_strings.dart';
import '../../constant/app_text_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController jerseyNumberController = TextEditingController();
  final TextEditingController instagramHandleController = TextEditingController();

  String? selectedGender = 'Male';
  String? selectedTeam = 'Hornets';
  String? selectedPosition = 'Center';
  String? selectedCountry = 'US';

  final List<String> genders = ['Male', 'Female', 'Other'];
  final List<String> teams = ['Hornets', 'Lakers', 'Bulls', 'Celtics'];
  final List<String> positions = ['Point Guard', 'Shooting Guard', 'Small Forward', 'Power Forward', 'Center'];
  final List<String> countries = ['US', 'Canada', 'UK', 'Australia'];
  @override
  Widget build(BuildContext context) {
    return Padding(padding:
    EdgeInsets.symmetric(horizontal: 20,vertical: 25),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
            margin: EdgeInsets.only(top: 50,bottom: 25),
        height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: AppColors.faq,
                borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.appColor,width: 5)
        )
              ),
        
            dataFormWidget()],
        ),
      ),
    );
  }
  Widget dataFormWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(children: [
            Flexible(child: CommonTextField(controller: firstNameController,label:  AppStrings.fName,hint:"Michael",numType: false)),

            SizedBox(width: 10,),
            Flexible(child: CommonTextField(controller: lastNameController,label:  AppStrings.lName,hint:  "Johnson",numType: false)),

          ],),

          Row(
            children: [
              Flexible(
                child: buildDropdownField("Your Gender", genders, selectedGender, (value) => setState(() => selectedGender = value)),),
              SizedBox(width: 15),
              Flexible(
                child:buildDropdownField("Your Future Team", teams, selectedTeam, (value) => setState(() => selectedTeam = value)),)
            ],
          ),
          SizedBox(height: 25),

          Row(
            children: [
              Flexible(
                child:  buildDropdownField("Your Position", positions, selectedPosition, (value) => setState(() => selectedPosition = value)),
              ),
              SizedBox(width: 10),
              Flexible(
                child: CommonTextField(controller: jerseyNumberController,label:  AppStrings.stl,hint:  AppStrings.stl,numType: true,),),
            ],
          ),
          SizedBox(height: 25),

          Row(
            children: [
              Flexible(child: buildDropdownField("Your Country Name", countries, selectedCountry, (value) => setState(() => selectedCountry = value))),
              SizedBox(width: 15),
              Flexible(
                child: CommonTextField(controller: instagramHandleController,label:  AppStrings.blk,hint:  AppStrings.blk,numType: true),),

            ],
          ),
        ],
      ),
    );
  }
  Widget buildDropdownField(String label, List<String> options, String? selectedValue, ValueChanged<String?> onChanged) {
    return SizedBox(
      // width: double.infinity, // Ensures the dropdown does not exceed available space
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor)),
          SizedBox(height: 3),
          DropdownButtonFormField<String>(
            dropdownColor: Colors.black,
            value: selectedValue,
            items: options.map((e) => DropdownMenuItem(value: e, child: Text(e,style: AppTextStyles.getOpenSansGoogleFont( 12, AppColors.whiteColor,false)),)).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.faq,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
