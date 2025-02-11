import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:q_bounce/common_widget/common_button.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_images.dart';
import 'package:q_bounce/constant/app_strings.dart';

import '../../app_services/common_Capital.dart';
import '../../common_widget/common_alert.dart';
import '../../common_widget/custom_snackbar.dart';
import '../../constant/app_text_style.dart';
import '../state_screen_view/statistics_bloc/statistics_bloc.dart';
import '../state_screen_view/statistics_bloc/statistics_event.dart';
import '../state_screen_view/statistics_bloc/statistics_state.dart';
import '../state_screen_view/statistics_bloc/statistics_view_model/GetStatisticsResponse.dart';
import '../state_screen_view/statistics_delete_bloc/statistics_delete_bloc.dart';
import '../state_screen_view/statistics_delete_bloc/statistics_delete_event.dart';
import '../state_screen_view/statistics_delete_bloc/statistics_delete_state.dart';
import '../state_screen_view/statistics_edit_bloc/statistics_edit_bloc.dart';
import '../state_screen_view/statistics_store_bloc/statistics_store_bloc.dart';
import '../state_screen_view/statistics_update_bloc/statistics_update_bloc.dart';
import '../statistics_edit_view/statistics_edit_screen.dart';

class YourStatsScreen extends StatefulWidget {
  const YourStatsScreen({super.key});

  @override
  State<YourStatsScreen> createState() => _YourStatsScreenState();
}

class _YourStatsScreenState extends State<YourStatsScreen> {
  List<StatisticsData> statisticsData = [];
  int? deletingId;
  @override
  void initState() {
    super.initState();
    context.read<StatisticsBloc>().add(FetchStatistics());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 25),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(AppStrings.yourState.toUpperCase(),style: AppTextStyles.athleticStyle(fontSize: 28, fontFamily: AppTextStyles.athletic, color: AppColors.whiteColor)),
            BlocBuilder<StatisticsBloc, StatisticsState>(
              builder: (context, state) {
                if (state is StatisticsLoading) {
                  return Center(child: CircularProgressIndicator(color: AppColors.appColor,));
                } else if (state is StatisticsLoaded) {
                  statisticsData = state.getStatisticsResponse.data ?? [];
                  if (statisticsData.isEmpty) {
                    return Center(child: Text(AppStrings.noSTData.toUpperCase(),style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.athletic, color: AppColors.whiteColor)));
                  }
                  return statisticTable(statisticsData);
                } else if (state is StatisticsError) {
                  return Center(child: Text(state.errorMessage.toUpperCase(), style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.athletic, color: AppColors.whiteColor)));
                } else {
                  return Center(child: Text(AppStrings.somethingW.toUpperCase(),style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.athletic, color: AppColors.whiteColor)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
Widget statisticTable(List<StatisticsData> statistics){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: statistics.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var latestGame = statistics[index];
        List<Map<String, String>> stateData = [
          {"name": "PTS", "point": latestGame.pointsScored.toString()},
          {"name": "REB", "point": latestGame.rebounds.toString()},
          {"name": "AST", "point": latestGame.assists.toString()},
          {"name": "STL", "point": latestGame.steals.toString()},
          {"name": "BLK", "point": latestGame.blockedShots.toString()},
        ];
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Slidable(
            closeOnScroll: true, // Ensures only one slider stays open
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      GlobleValue.selectedIndex.value=1;
                      GlobleValue.button.value=0;
                      GlobleValue.selectedScreen.value = MultiBlocProvider(
                        providers: [
                          BlocProvider<StatisticsEditBloc>(
                            create: (BuildContext context) => StatisticsEditBloc(),
                          ),
                          BlocProvider<StatisticsUpdateBloc>(
                            create: (BuildContext context) => StatisticsUpdateBloc(),
                          ),
                          BlocProvider<StatisticsStoreBloc>(
                            create: (BuildContext context) => StatisticsStoreBloc(),
                          ),
                        ],
                        child: StatisticsEditScreen(Id: latestGame.id),
                      );
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFD74B16),

                    ),
                    child: AppImages.image(AppImages.edit, height: 35, width: 35, fit: BoxFit.fitWidth),
                  ),
                ),
                InkWell(
                  onTap: () {

                    showAlertDialog(context,AppStrings.yesDelete,AppStrings.alertDesc,() {
                      Navigator.pop(context);
                    },
                    latestGame.id
                    );
                    // Navigator.pop(context); // Close drawer
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFD31D0B),

                    ),
                    child: AppImages.image(AppImages.delete, height: 35, width: 35, fit: BoxFit.fitWidth),
                  ),
                ),

              ],
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage("assets/images/stateBG.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppImages.image(AppImages.ballImage, height: 30, width: 30),
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            statistics[index].opponentTeam,
                            style: TextStyle(fontSize: 22, color: AppColors.whiteColor, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            statistics[index].gameDate.substring(0, 10),
                            style: TextStyle(fontSize: 13, color: AppColors.whiteColor.withOpacity(0.5), fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFD74B16), Color(0xFFE9B6A3)],
                        begin: Alignment.center,
                        end: Alignment.center,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                      stateData.map((item) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Text(
                                item['name']!,
                                style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                item['point']!,
                                style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },);
}
  Future showAlertDialog(BuildContext context,String confirm,String subTitle,VoidCallback confirmAction, int latestGameId) {
    return  showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider<StatisticsDeleteBloc>(
          create: (BuildContext context) => StatisticsDeleteBloc(),
          child: AlertDialog(
            backgroundColor: AppColors.alertColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            title: Center(
              child: AppImages.image(
                AppImages.confirmDelete,
                height: 78,
                width: 80,
                fit: BoxFit.fitWidth,
              ),
            ),
            content: SizedBox(
              width: 300, // Set a fixed width for the dialog
              child: Column(
                mainAxisSize: MainAxisSize.min, // Prevent infinite height
                children: [
                  Text(
                    AppStrings.areYouSure,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.athleticStyle(
                      fontSize: 24,
                      fontFamily: AppTextStyles.sfPro700,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  SizedBox(height: 8), // Add spacing
                  Text(
                    subTitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.getOpenSansBoldGoogleFont(
                      18, AppColors.whiteColor, false,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute buttons evenly
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CommonButton(title: AppStrings.cancel, color: AppColors.faq,horizontal: 10,font: 14,)),
                  ),
                  SizedBox(width: 10,),
                  BlocConsumer<StatisticsDeleteBloc, StatisticsDeleteState>(
                    builder: (context, state) {
                      if (state is StatisticsDeleteLoading && deletingId == latestGameId) {
                        return CircularProgressIndicator(color: AppColors.appColor,);
                      }
                      return InkWell(
                        onTap: () {
                          setState(() {
                            deletingId = latestGameId;
                          });
                          BlocProvider.of<StatisticsDeleteBloc>(context).add(FetchStatisticsDelete(deletingId as int));
                        },
                        child: Expanded(
                          child: CommonButton(title: confirm, color: AppColors.appColor,horizontal: 10,font: 14,),
                        ),
                      );
                    },
                    listener: (context, state) {
                      if (state is StatisticsDeleteLoaded) {

                        setState(() {
                          statisticsData.removeWhere((element) => element.id == deletingId);
                          deletingId = null;
                          Navigator.pop(context);
                        });
                        ScaffoldMessengerHelper.showMessage(state.postStatisticsDeleteResponse.message.toString());
                      } else if (state is StatisticsDeleteError) {
                        ScaffoldMessengerHelper.showMessage(state.errorMessage
                        );
                        setState(() {
                          deletingId = null;
                        });
                      }
                    },
                  ),

                ],
              ),
            ],
          ),
        );
      },
    );
  }

}
