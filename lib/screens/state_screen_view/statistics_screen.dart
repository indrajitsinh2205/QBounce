import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/app_services/navigation_service.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_strings.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_bloc.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_event.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_state.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_bloc/statistics_view_model/GetStatisticsResponse.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_bloc.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_event.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_delete_bloc/statistics_delete_state.dart';

import '../../common_widget/custom_snackbar.dart';


class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  List<StatisticsData> statisticsData = [];
  int? deletingId;

  @override
  void initState() {
    super.initState();
    context.read<StatisticsBloc>().add(FetchStatistics());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, right: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Future.delayed(Duration(milliseconds: 100), () {
                  NavigationService.navigateTo(NavigationService.edit);
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.appColor),
                child: Text(
                  AppStrings.addMatch,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            BlocBuilder<StatisticsBloc, StatisticsState>(
              builder: (context, state) {
                if (state is StatisticsLoading) {
                  return Center(child: CircularProgressIndicator(color: AppColors.appColor,));
                } else if (state is StatisticsLoaded) {
                  statisticsData = state.getStatisticsResponse.data ?? [];
                  if (statisticsData.isEmpty) {
                    return Center(child: Text(AppStrings.noSTData));
                  }
                  return StatisticTable(statisticsData);
                } else if (state is StatisticsError) {
                  return Center(child: Text(state.errorMessage, style: TextStyle(color: Colors.red)));
                } else {
                  return Center(child: Text(AppStrings.somethingW));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget StatisticTable(List<StatisticsData> statistics) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text("Date")),
            DataColumn(label: Text("Opponent")),
            DataColumn(label: Text("Location")),
            DataColumn(label: Text("PTS", textAlign: TextAlign.center)),
            DataColumn(label: Text("REB", textAlign: TextAlign.center)),
            DataColumn(label: Text("AST", textAlign: TextAlign.center)),
            DataColumn(label: Text("STL", textAlign: TextAlign.center)),
            DataColumn(label: Text("BLK", textAlign: TextAlign.center)),
            DataColumn(label: Text("Actions", textAlign: TextAlign.center)),
          ],
          rows: List.generate(statistics.length, (index) {
            final item = statistics[index];
            return DataRow(cells: [
              DataCell(Text(item.gameDate.substring(0, 10) ?? "N/A")),
              DataCell(Text(item.opponentTeam ?? "N/A")),
              DataCell(Text(item.location ?? "N/A")),
              DataCell(Text(item.pointsScored.toString() ?? "0", textAlign: TextAlign.center)),
              DataCell(Text(item.rebounds.toString() ?? "0", textAlign: TextAlign.center)),
              DataCell(Text(item.assists.toString() ?? "0", textAlign: TextAlign.center)),
              DataCell(Text(item.steals.toString() ?? "0", textAlign: TextAlign.center)),
              DataCell(Text(item.blockedShots.toString() ?? "0", textAlign: TextAlign.center)),
              DataCell(
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.orange),
                      onPressed: () {
                        Future.delayed(Duration(milliseconds: 100), () {
                          NavigationService.navigateTo(arguments: item.id, NavigationService.edit);
                        });
                      },
                    ),
                    BlocConsumer<StatisticsDeleteBloc, StatisticsDeleteState>(
                      builder: (context, state) {
                        if (state is StatisticsDeleteLoading && deletingId == item.id) {
                          return CircularProgressIndicator(color: AppColors.appColor,);
                        }
                        return IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              deletingId = item.id;
                            });
                            BlocProvider.of<StatisticsDeleteBloc>(context).add(FetchStatisticsDelete(deletingId as int));
                          },
                        );
                      },
                      listener: (context, state) {
                        if (state is StatisticsDeleteLoaded) {

                          setState(() {
                            statisticsData.removeWhere((element) => element.id == deletingId);
                            deletingId = null;
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
              ),
            ]);
          }),
        ),
      ),
    );
  }
}
