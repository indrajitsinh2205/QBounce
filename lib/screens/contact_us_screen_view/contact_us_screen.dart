import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_widget/common_button.dart';
import '../../common_widget/common_text_field.dart';
import '../../common_widget/custom_snackbar.dart';
import '../../constant/app_color.dart';
import '../../constant/app_strings.dart';
import '../../constant/app_text_style.dart';
import 'contact_us_bloc/contact_us_bloc.dart';
import 'contact_us_bloc/contact_us_event.dart';
import 'contact_us_bloc/contact_us_state.dart';
import 'contact_us_view_model/contact_us_request_model.dart';

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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
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
          CommonTextField(icon: Icon(Icons.mail_outline_outlined) ,controller: _staticMailController,hint:  AppStrings.staticMail, label: '',boarder: true,readOnly: true,),
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
          CommonTextField(controller: _messageController,label:  AppStrings.message,hint:  AppStrings.message,textArea: true,),
          SizedBox(height: 15),
          Row(
            children: [
              BlocConsumer<ContactUsBloc, ContactUsState>(
                listener: (context, state) {
                  if (state is ContactUsLoaded) {
                    ScaffoldMessengerHelper.showMessage(state.contactUsResponse.message.toString());
                  }
                },
                builder: (context, state) {
                  if(state is ContactUsLoading){
                    return CircularProgressIndicator(color: AppColors.appColor,);
                  }
                  if(state is ContactUsLoaded){
                    // Future.delayed(Duration(milliseconds: 100), () {
                    //   setState(() {
                    //     GlobleValue.button.value =1;
                    //   });
                    //   GlobleValue.selectedScreen.value = MultiBlocProvider(
                    //       providers: [
                    //         BlocProvider<StatisticsBloc>(
                    //           create: (BuildContext context) => StatisticsBloc(),
                    //         ),
                    //         BlocProvider<StatisticsDeleteBloc>(
                    //           create: (BuildContext context) => StatisticsDeleteBloc(),
                    //         ),
                    //       ],
                    //       child: YourStatsScreen());
                    //   // NavigationService.navigateTo(NavigationService.statistics);
                    // });
                  }
                  return GestureDetector(
                      onTap: () {
                        ContactUsRequestModel postData = ContactUsRequestModel(
                       email: _uMailController.text,
                          firstName: _fNameController.text,
                          lastName: _lNameController.text,
                         message: _messageController.text
                        );
                        BlocProvider.of<ContactUsBloc>(context).add(FetchContactUs( postData));
                      },
                      child: CommonButton(title: AppStrings.save,color: AppColors.appColor,),
                  );
                },
              ),
              Spacer()
            ],
          )        ],
      ),
    );
  }

}
