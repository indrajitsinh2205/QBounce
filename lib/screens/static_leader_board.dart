import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_text_style.dart';
import 'package:q_bounce/screens/home_screen_view/home_widget/leader_board.dart';

import '../constant/app_images.dart';
import 'home_screen_view/home_widget/build_rank_container.dart';
import 'leaderboard_screen_view/leaderboard_bloc/leader_board_bloc.dart';
import 'leaderboard_screen_view/leaderboard_bloc/leader_board_event.dart';
import 'leaderboard_screen_view/leaderboard_bloc/leader_board_state.dart';
import 'leaderboard_screen_view/leaderboard_view_model/LeaderBoardResponse.dart';

class StaticLeaderBoard extends StatefulWidget {
  const StaticLeaderBoard({super.key});

  @override
  State<StaticLeaderBoard> createState() => _StaticLeaderBoardState();
}

class _StaticLeaderBoardState extends State<StaticLeaderBoard> {



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          LeaderBoard(
            scoreBool: false,
            onLevelSelected: (level) {
              print("Selected Level: $level");

              context.read<LeaderBoardBloc>().add(FetchLeaderBoard(level));
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 00.0, vertical: 20),
            child: Expanded(
              child: BlocBuilder<LeaderBoardBloc, LeaderBoardState>(
                builder: (context, state) {
                  if (state is LeaderBoardLoading) {
                    return Center(child: CircularProgressIndicator(color: AppColors.appColor,));
                  } else if (state is LeaderBoardLoaded) {
                    print("Loaded");
                    final leadersData = state.leaderBoardResponse.data.leaders;
                    return userList(leadersData);
                  } else if (state is LeaderBoardError) {
                    return Center(child: Text('${state.errorMessage}'));
                  } else {
                    return Center(child: Text('Something Went Wrong'));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget userList(List<Leaders> leaders) {
    for (int i = 0; i < 3 && i < leaders.length; i++) {
      final leader = leaders[i];
      final media = leader.user.media ?? [];
      final mediaUrl = media.isNotEmpty ? media[0].originalUrl : null;
    }

    return Column(
      children: [
        Row (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (leaders.length > 1)
              BuildRankContainer(
                point: leaders[1].totalRewardPoints.toString(),
                bottom: 20,
                top: 0.0020,
                left: 0.085,
                height: 170,
                logoHeight: 63,
                personImage: leaders[1].user.media.isNotEmpty
                    ? leaders[1].user.media[0].originalUrl
                    : '',
                rankBackground: AppImages.rank2,
                name: leaders[1].user.firstName + leaders[1].user.lastName,
              ),
            if (leaders.length > 0)
              BuildRankContainer(
                point: leaders[0].totalRewardPoints.toString(),
                bottom: 0.008,
                top: 0.068,
                left: 0.028,
                height: 248,
                logoHeight: 105,
                personImage: leaders[0].user.media.isNotEmpty
                    ? leaders[0].user.media[0].originalUrl
                    : '',
                rankBackground: AppImages.rank1,
                name: leaders[0].user.firstName + leaders[0].user.lastName,
                isCrowned: true,
              ),
            if (leaders.length > 2)
              BuildRankContainer(
                point: leaders[2].totalRewardPoints.toString(),

                bottom: 20,
                top: 0.0020,
                left: 0.085,
                height: 170,
                logoHeight: 63,
                personImage: leaders[2].user.media.isNotEmpty
                    ? leaders[2].user.media[0].originalUrl
                    : '',
                rankBackground: AppImages.rank3,
                name: leaders[2].user.firstName + leaders[2].user.lastName,
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: leaders.length > 3 ? leaders.length - 3 : 0,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var data = leaders[index + 3];
              final media = data.user.media ?? [];
              final mediaUrl = media.isNotEmpty ? media[0].originalUrl : null;

              return Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.alertColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 23,
                        child: Text(
                          data.userId.toString(),
                          style: AppTextStyles.athleticStyle(
                              fontSize: 12,
                              fontFamily: AppTextStyles.sfPro500,
                              color: AppColors.whiteColor),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        child: mediaUrl != null
                            ? Image.network(
                          mediaUrl.toString(),
                          height: 32,
                          width: 32,
                        )
                            : Icon(Icons.person),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.start,
                          data.user.firstName + data.user.lastName,
                          style: AppTextStyles.athleticStyle(
                              fontSize: 12,
                              fontFamily: AppTextStyles.sfPro500,
                              color: AppColors.whiteColor),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            data.user.country,
                            style: AppTextStyles.athleticStyle(
                                fontSize: 12,
                                fontFamily: AppTextStyles.sfPro500,
                                color: AppColors.whiteColor),
                          ),
                          SizedBox(width: 15),
                          Text(
                            data.totalRewardPoints.toString(),
                            style: AppTextStyles.athleticStyle(
                                fontSize: 12,
                                fontFamily: AppTextStyles.sfPro500,
                                color: AppColors.whiteColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
