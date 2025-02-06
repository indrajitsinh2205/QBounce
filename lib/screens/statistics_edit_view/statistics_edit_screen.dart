import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:q_bounce/app_services/navigation_service.dart';
import 'package:q_bounce/common_widget/common_button.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_strings.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_view_model/post_statistics_update_request.dart';

import '../../common_widget/common_text_field.dart';
import '../../common_widget/custom_snackbar.dart';
import '../../constant/app_text_style.dart';
import '../state_screen_view/statistics_edit_bloc/statistics_edit_bloc.dart';
import '../state_screen_view/statistics_edit_bloc/statistics_edit_event.dart';
import '../state_screen_view/statistics_edit_bloc/statistics_edit_state.dart';
import '../state_screen_view/statistics_store_bloc/statistics_store_bloc.dart';
import '../state_screen_view/statistics_store_bloc/statistics_store_event.dart';
import '../state_screen_view/statistics_store_bloc/statistics_store_state.dart';
import '../state_screen_view/statistics_store_bloc/statistics_store_view_model/statistics_store_request.dart';
import '../state_screen_view/statistics_update_bloc/statistics_update_bloc.dart';
import '../state_screen_view/statistics_update_bloc/statistics_update_event.dart';
import '../state_screen_view/statistics_update_bloc/statistics_update_state.dart';

class StatisticsEditScreen extends StatefulWidget {
  var Id;
   StatisticsEditScreen({super.key,  this.Id});

  @override
  State<StatisticsEditScreen> createState() => _StatisticsEditScreenState();
}

class _StatisticsEditScreenState extends State<StatisticsEditScreen> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _opponentController = TextEditingController();
  final TextEditingController _PTSController = TextEditingController();
  final TextEditingController _REBController = TextEditingController();
  final TextEditingController _ASTController = TextEditingController();
  final TextEditingController _STLController = TextEditingController();
  final TextEditingController _BLKController = TextEditingController();

  String selectedDate = ""; 

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.isEmpty ? DateTime.now() : DateTime.parse(selectedDate), 
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat(AppStrings.dateFormat).format(pickedDate); 
      setState(() {
        selectedDate = formattedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.Id > 0) {
      context.read<StatisticsEditBloc>().add(FetchStatisticsEdit(widget.Id));
    } else {
      setState(() {
        _locationController.clear();
        _opponentController.clear();
        _PTSController.clear();
        _REBController.clear();
        _ASTController.clear();
        _STLController.clear();
        _BLKController.clear();
        selectedDate = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
          child: widget.Id > 0?BlocBuilder<StatisticsEditBloc, StatisticsEditState>(
            builder: (context, state) {
              if (state is StatisticsEditLoading) {
                return Center(child: CircularProgressIndicator(color: AppColors.appColor,));
              } else if (state is StatisticsEditLoaded) {
                if (widget.Id > 0) {
                  _locationController.text = state.getStatisticsEditResponse.data!.statistics!.location.toString();
                  _opponentController.text = state.getStatisticsEditResponse.data!.statistics!.opponentTeam.toString();
                  _PTSController.text = state.getStatisticsEditResponse.data!.statistics!.pointsScored.toString();
                  _REBController.text = state.getStatisticsEditResponse.data!.statistics!.rebounds.toString();
                  _ASTController.text = state.getStatisticsEditResponse.data!.statistics!.assists.toString();
                  _STLController.text = state.getStatisticsEditResponse.data!.statistics!.steals.toString();
                  _BLKController.text = state.getStatisticsEditResponse.data!.statistics!.blockedShots.toString();
                  selectedDate = state.getStatisticsEditResponse.data!.statistics!.gameDate.toString().substring(0, 10);
                }
                return FormUI();
              } else if (state is StatisticsEditError) {
                return Center(child: Text(state.errorMessage, style: TextStyle(color: Colors.red)));
              } else {
                return Center(child: Text(AppStrings.somethingW, style: TextStyle(color: Colors.white)));
              }
            },
          ):FormUI()
      ),
    );
  }


  Widget FormUI() {
    return SingleChildScrollView(
      child: Column(
        children: [
          dataFormWidget(),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.Id > 0?updateData():saveData(),
              // CommonButton(title: "cancel", color: AppColors.faq,),
            ],
          )
        ],
      ),
    );
  }
  Widget updateData() {
    return BlocConsumer<StatisticsUpdateBloc, StatisticsUpdateState>(
      listener: (context, state) {
        if (state is StatisticsUpdateLoaded) {
          ScaffoldMessengerHelper.showMessage(state.postStatisticsUpdateResponse.message.toString());
        }
      },
      builder: (context, state) {
        if(state is StatisticsUpdateLoading){
          return CircularProgressIndicator(color: AppColors.appColor,);
        }
        if(state is StatisticsUpdateLoaded){
          Future.delayed(Duration(milliseconds: 100), () {
            NavigationService.navigateTo(NavigationService.statistics);
          });


        }
        return GestureDetector(
          onTap: () {
            PostStatisticsUpdateRequestRequestModel postData = PostStatisticsUpdateRequestRequestModel(
              location: _locationController.text,
              opponentTeam: _opponentController.text,
              pointsScored: _PTSController.text,
              rebounds: _REBController.text,
              assists: _ASTController.text,
              steals: _STLController.text,
              blockedShots: _BLKController.text,
              gameDate: selectedDate,
            );
            BlocProvider.of<StatisticsUpdateBloc>(context).add(FetchStatisticsUpdate(widget.Id, postData));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.appColor),
            child: Text(
              AppStrings.update,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
        );
      },
    );
  }

  Widget saveData() {
    return BlocConsumer<StatisticsStoreBloc, StatisticsStoreState>(
      listener: (context, state) {
        if (state is StatisticsStoreLoaded) {
          ScaffoldMessengerHelper.showMessage(state.postStatisticsStoreResponse.message.toString());
        }
      },
      builder: (context, state) {
        if(state is StatisticsStoreLoading){
          return CircularProgressIndicator(color: AppColors.appColor,);
        }
        if(state is StatisticsStoreLoaded){
          Future.delayed(Duration(milliseconds: 100), () {
            NavigationService.navigateTo(NavigationService.statistics);
          });
        }
        return GestureDetector(
          onTap: () {
            // PostStatisticsStoreRequestModel postData = PostStatisticsStoreRequestModel(
            //   location: _locationController.text,
            //   opponentTeam: _opponentController.text,
            //   pointsScored: _PTSController.text,
            //   rebounds: _REBController.text,
            //   assists: _ASTController.text,
            //   steals: _STLController.text,
            //   blockedShots: _BLKController.text,
            //   gameDate: selectedDate,
            // );
            // BlocProvider.of<StatisticsStoreBloc>(context).add(FetchStatisticsStore( postData));
          },
          child: CommonButton(title: "Save", color: AppColors.appColor)
        );
      },
    );
  }

  Widget dataFormWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          CommonTextField(controller: _locationController,label:  AppStrings.location,hint:  AppStrings.location,numType: false),
          SizedBox(height: 25),
          CommonTextField(controller: _opponentController,label:  AppStrings.opponent,hint:  AppStrings.opponent,numType: false),
          SizedBox(height: 25),

          Row(
            children: [
              Flexible(
                child: CommonTextField(controller: _PTSController,label:  AppStrings.pts,hint:  AppStrings.pts,numType: true),),
              SizedBox(width: 15),
              Flexible(
                child: CommonTextField(controller: _REBController,label:  AppStrings.reb,hint:  AppStrings.reb,numType: true),),
            ],
          ),
          SizedBox(height: 25),

          Row(
            children: [
              Flexible(
                child: CommonTextField(controller: _ASTController,label:  AppStrings.ast,hint:  AppStrings.ast,numType: true),),
              SizedBox(width: 15),
              Flexible(
                child: CommonTextField(controller: _STLController,label:  AppStrings.stl,hint:  AppStrings.stl,numType: true,),),
            ],
          ),
          SizedBox(height: 25),

          Row(
            children: [
              Flexible(
                child: CommonTextField(controller: _BLKController,label:  AppStrings.blk,hint:  AppStrings.blk,numType: true),),
              SizedBox(width: 15),
              commonCalender(),
            ],
          ),
        ],
      ),
    );
  }

  Widget commonCalender() {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.match,style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor)),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.faq),
                color: AppColors.faq
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate.isEmpty ? AppStrings.dateFormat : selectedDate, 
                    style: AppTextStyles.getOpenSansGoogleFont(12, AppColors.whiteColor.withOpacity(0.5), false),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _selectDate(context); // Open date picker
                  },
                  icon: Icon(Icons.calendar_month,color: AppColors.whiteColor,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget commonTextField(TextEditingController controller, String label, String hint, bool? numType) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
  //         TextField(
  //           keyboardType: numType==true?TextInputType.number:TextInputType.name,
  //           controller: controller,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(),
  //             hintText: hint,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

