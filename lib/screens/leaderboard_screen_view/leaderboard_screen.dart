import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/screens/leaderboard_screen_view/leaderboard_bloc/leader_board_event.dart';

import '../../common_widget/common_tab_bar.dart';
import 'leaderboard_bloc/leader_board_bloc.dart';
import 'leaderboard_bloc/leader_board_state.dart';
import 'leaderboard_view_model/LeaderBoardResponse.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>  with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    _fetchInitialLeaderBoard("overall");
  }
  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      final trainingLevels = ["overall", "week", "month"];
      final selectedLevel = trainingLevels[_tabController.index];

      _fetchLeaderBoardData(selectedLevel);
    }
  }
  void _fetchInitialLeaderBoard(String level) {
    print("LeaderBoard");
    context.read<LeaderBoardBloc>().add(FetchLeaderBoard(level));
  }
  void _fetchLeaderBoardData(String level) {
    context.read<LeaderBoardBloc>().add(FetchLeaderBoard(level));
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, right: 10, left: 10),
        child: Column(
          children: [
            CommonTabBar(
              initialIndex: 0,
              tabTitles: ["overall", "week", "month"],
              Box: true,
              controller: _tabController,
            ),
            Expanded(
              child: BlocBuilder<LeaderBoardBloc, LeaderBoardState>(
                builder: (context, state) {
                  if (state is LeaderBoardLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is LeaderBoardLoaded) {
                    final leadersData = state.leaderBoardResponse.data.leaders;

                    return LeaderBoardData(leadersData);
                  } else if (state is LeaderBoardError) {
                    return Center(child: Text('${state.errorMessage}'));
                  } else {
                    return Center(child: Text('Something Went Wrong'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget LeaderBoardData(List<Leaders> leaders) {
    // Split the first three items into a row
    List<Widget> firstThreeItems = [];
    for (int i = 0; i < 3 && i < leaders.length; i++) {
      final leader = leaders[i];
      final media = leader.user.media ?? [];
      final mediaUrl = media.isNotEmpty ? media[0].originalUrl : null;

      firstThreeItems.add(
        Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: AppColors.termColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(

            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: mediaUrl != null
                      ? NetworkImage(mediaUrl)
                      : null,
                  child: mediaUrl == null ? Icon(Icons.person) : null,
                ),
              ),
              Text(
                "${leader.user.firstName} ${leader.user.lastName}",
                style: TextStyle(color: AppColors.whiteColor),
              ),
              Text(
                "${leader.totalRewardPoints} XP",
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        // First three items in a Row
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: firstThreeItems,
        ),
        // Remaining items in ListView
        ListView.separated(
          shrinkWrap: true,
          itemCount: leaders.length > 3 ? leaders.length - 3 : 0,
          itemBuilder: (context, index) {
            final leader = leaders[index + 3]; // Adjust index for remaining items
            final media = leader.user.media ?? [];
            final mediaUrl = media.isNotEmpty ? media[0].originalUrl : null;

            return Container(
              decoration: BoxDecoration(
                color: AppColors.termColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: mediaUrl != null
                        ? NetworkImage(mediaUrl)
                        : null,
                    child: mediaUrl == null ? Icon(Icons.person) : null,
                  ),
                ),
                title: Text(
                  "${leader.user.firstName} ${leader.user.lastName}",
                  style: TextStyle(color: AppColors.whiteColor),
                ),
                trailing: Text(
                  "${leader.totalRewardPoints} XP",
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 15),
        ),
      ],
    );
  }


}
