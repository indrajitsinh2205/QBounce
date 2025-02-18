import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:q_bounce/app_services/navigation_service.dart';
import 'package:q_bounce/common_widget/common_app_bar.dart';
import 'package:q_bounce/common_widget/common_button.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_images.dart';
import 'package:q_bounce/constant/app_strings.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_view_model/post_statistics_update_request.dart';

import '../../app_services/common_Capital.dart';
import '../../common_widget/common_text_field.dart';
import '../../common_widget/custom_snackbar.dart';
import '../../constant/app_text_style.dart';
import '../state_screen_view/statistics_bloc/statistics_bloc.dart';
import '../state_screen_view/statistics_delete_bloc/statistics_delete_bloc.dart';
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
import '../your_stats_screen_view/your_stats_screen.dart';

class StatisticsEditScreen extends StatefulWidget {
  var Id;
  final Function? voidCallbacksuccess;

  StatisticsEditScreen({super.key,  this.Id, this.voidCallbacksuccess});

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
  final TextEditingController _DateController = TextEditingController();

  // String selectedDate = "";

  Future<void> _selectDate(BuildContext context) async {
    DateTime? initialDate;

    // Validate and parse selectedDate if it's not empty
    if (GlobleValue.selectedDate.value.isNotEmpty) {
      try {
        initialDate = DateFormat('yyyy-MM-dd').parse(GlobleValue.selectedDate.value);
      } catch (e) {
        initialDate = DateTime.now(); // Fallback if parsing fails
      }
    } else {
      initialDate = DateTime.now();
    }

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.appColor, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Text color
            ),
            dialogBackgroundColor: Colors.grey[200], // Background color
          ),
          child: child!,
        );
      },
    );


    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        GlobleValue.selectedDate.value = formattedDate; // Update notifier value
        _DateController.text = formattedDate;          // Update controller text
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
        GlobleValue.selectedDate.value = "";
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
                  // _DateController.text = state.getStatisticsEditResponse.data!.statistics!.gameDate.toString().substring(0, 10); // Update selectedDate
                  GlobleValue.selectedDate.value = state.getStatisticsEditResponse.data!.statistics!.gameDate.toString().substring(0, 10); // Update selectedDate
                 }
                return FormUI();
              } else if (state is StatisticsEditError) {
                return Center(child: Text(state.errorMessage, style: TextStyle(color: Colors.red)));
              } else {
                return Center(child: Text(AppStrings.somethingW, style: TextStyle(color: Colors.white)));
              }
            },
          )
              : FormUI(),
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
              widget.Id > 0 ? updateData() : saveData(),
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
        if(state is StatisticsUpdateError){
            ScaffoldMessengerHelper.showMessage(state.errorMessage.toString());
        }
      },
      builder: (context, state) {
        if (state is StatisticsUpdateLoading) {
          return CircularProgressIndicator(color: AppColors.appColor);
        }
        if (state is StatisticsUpdateLoaded) {
          Future.delayed(Duration(milliseconds: 100), () {
            setState(() {
              GlobleValue.button.value = 1;
              // GlobleValue.selectedIndex.value = 1;
              // GlobleValue.currentIndex.value = 1;
              // GlobleValue.overlayScreen.value = null;
              widget.voidCallbacksuccess!();
              GlobleValue.overlayScreen.value = MultiBlocProvider(
                  providers: [
                    BlocProvider<StatisticsBloc>(create: (BuildContext context) => StatisticsBloc()),
                    BlocProvider<StatisticsDeleteBloc>(create: (BuildContext context) => StatisticsDeleteBloc()),
                  ],
                  child: YourStatsScreen());
            });

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
              gameDate: _DateController.text,
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
        if (state is StatisticsStoreError) {
          ScaffoldMessengerHelper.showMessage(state.errorMessage.toString());
        }
      },
      builder: (context, state) {
        if (state is StatisticsStoreLoading) {
          return CircularProgressIndicator(color: AppColors.appColor);
        }
        if (state is StatisticsStoreLoaded) {
          Future.delayed(Duration(milliseconds: 100), () {
            setState(() {
              GlobleValue.button.value = 1;
              // GlobleValue.selectedIndex.value = 1;
              // GlobleValue.currentIndex.value = 1;
              // GlobleValue.overlayScreen.value = null;
              widget.voidCallbacksuccess!();
              GlobleValue.overlayScreen.value = MultiBlocProvider(
                  providers: [
                    BlocProvider<StatisticsBloc>(create: (BuildContext context) => StatisticsBloc()),
                    BlocProvider<StatisticsDeleteBloc>(create: (BuildContext context) => StatisticsDeleteBloc()),
                  ],
                  child: YourStatsScreen());
            });

          });
        }
        return GestureDetector(
          onTap: () {
            print("111111");
            if(
            _locationController.text.isEmpty||
                _opponentController.text.isEmpty||
                _PTSController.text.isEmpty||
                _REBController.text.isEmpty||
                _ASTController.text.isEmpty||
                _STLController.text.isEmpty||
                _BLKController.text.isEmpty||
                _DateController.text.isEmpty
            ) {
              ScaffoldMessengerHelper.showMessage("All field are required");
            }
              PostStatisticsStoreRequestModel postData = PostStatisticsStoreRequestModel(
                location: _locationController.text,
                opponentTeam: _opponentController.text,
                pointsScored: _PTSController.text,
                rebounds: _REBController.text,
                assists: _ASTController.text,
                steals: _STLController.text,
                blockedShots: _BLKController.text,
                gameDate: GlobleValue.selectedDate.value,
              );
              BlocProvider.of<StatisticsStoreBloc>(context).add(
                  FetchStatisticsStore(postData));
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
          Text(AppStrings.match,
              style: AppTextStyles.athleticStyle(
                  fontSize: 14,
                  fontFamily: AppTextStyles.sfPro700,
                  color: AppColors.whiteColor)),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.faq),
                color: AppColors.faq),
            child: Row(
              children: [
                Expanded(
                  child: ValueListenableBuilder<String>(
                    valueListenable: GlobleValue.selectedDate,
                    builder: (context, selectedDate, child) {
                      return TextField(
                        controller: _DateController,
                        readOnly: true,
                        style: AppTextStyles.getOpenSansGoogleFont(
                          12,
                          AppColors.whiteColor.withOpacity(0.5),
                          false,
                        ),
                        decoration: InputDecoration(
                          hintText: selectedDate.isEmpty
                              ? AppStrings.dateFormat
                              : selectedDate,
                          hintStyle: AppTextStyles.getOpenSansGoogleFont(
                            12,
                            AppColors.whiteColor.withOpacity(0.5),
                            false,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                            BorderSide(width: 1, color: Colors.transparent),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                            BorderSide(width: 1, color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                            BorderSide(width: 1, color: Colors.transparent),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context); // Open date picker
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AppImages.image(AppImages.calenderIcon,
                        height: 20, width: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
