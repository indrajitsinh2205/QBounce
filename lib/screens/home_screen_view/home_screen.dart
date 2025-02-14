import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/app_services/common_Capital.dart';
import 'package:q_bounce/common_widget/common_button.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_images.dart';
import 'package:q_bounce/constant/app_text_style.dart';
import 'package:q_bounce/screens/home_screen_view/get_level_profile_view_model/get_level_profile_response.dart';
import 'package:q_bounce/screens/home_screen_view/home_widget/gridComponent.dart';
import 'package:q_bounce/screens/home_screen_view/user_details_bloc/user_details_bloc.dart';
import 'package:q_bounce/screens/home_screen_view/user_details_bloc/user_details_event.dart';
import 'package:q_bounce/screens/home_screen_view/user_details_bloc/user_details_state.dart';
import 'package:video_player/video_player.dart';

import '../../app_services/app_preferences.dart';
import '../../common_widget/common_tab_bar.dart';
import '../../constant/app_strings.dart';
import '../leaderboard_screen_view/leaderboard_bloc/leader_board_bloc.dart';
import '../leaderboard_screen_view/leaderboard_bloc/leader_board_event.dart';
import '../leaderboard_screen_view/leaderboard_bloc/leader_board_state.dart';
import '../leaderboard_screen_view/leaderboard_view_model/LeaderBoardResponse.dart';
import '../training_screen_view/training_bloc/training_program_bloc.dart';
import '../training_screen_view/training_program_bloc/training_program_bloc.dart';
import '../training_screen_view/training_program_bloc/training_program_event.dart';
import '../training_screen_view/training_program_bloc/training_program_state.dart';
import '../training_screen_view/training_view_model/TrainingResponse.dart';
import 'get_level_profile_bloc/get_level_profile_bloc.dart';
import 'home_widget/build_rank_container.dart';
import 'home_widget/leader_board.dart';
import 'home_widget/video_component.dart';
import 'level_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin  {
  // String? _selectedText; // Null means show default UI
  //  String? selectedButton = "Beginner";
  String? _id ;
  String? currentCategory='' ;



  void _updateUI(String text, [String? id]) {
    setState(() {
      GlobleValue.selectedText.value = text;
      GlobleValue.selectedButton.value = CommonCapital.capitalizeEachWord(text);
      print("_selectedText ${GlobleValue.selectedText.value}");
      print("selectedButton ${GlobleValue.selectedButton.value}");

      if (id != null) {
        print("ID: $id");
        _id=id;
      }
    });
  }


  void resetUI() {
    setState(() {
      GlobleValue.selectedText.value = null; // Reset to default UI
    });
  }

  @override
  void initState() {
    context.read<TrainingProgramBloc>().add(FetchTraining('beginner'));
    context.read<UserDetailsBloc>().add(FetchUserDetails());
    context.read<UserDetailsBloc>().stream.listen((state) {
      if (state is UserDetailsLoaded) {
        // Fetch the training program based on the user's category
        setState(() {
          print("1234");
          currentCategory = state.userDetailsResponse.data?.categoryName?.toLowerCase();

        });
         print("currentCategory $currentCategory");

      }
    });
    super.initState();
  }
  final List<String> categories = ['Beginner', 'Advanced', 'Pro', 'Master'];
  int _getCategoryIndex(String category) {
    return categories.indexOf(category);
  }
  @override
  Widget build(BuildContext context) {
    print("currentCategory $currentCategory");
    int currentIndex = _getCategoryIndex(CommonCapital.capitalizeEachWord(currentCategory.toString()));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 25),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: categories.map((category) {
                    int index = _getCategoryIndex(category);
                    bool isLocked = index > currentIndex;
                    return Expanded(
                      child: _buildButton(category, isLocked),
                    );
                  }).toList(),
                ),
              ),
            ),

            ValueListenableBuilder<String?>(
              valueListenable: GlobleValue.selectedText,
              builder: (context, value, child) {
                return value == null
                    ? defaultUI()
                    : MultiBlocProvider(
                  providers: [
                    BlocProvider<TrainingProgramBloc>(
                      create: (BuildContext context) => TrainingProgramBloc(),
                    ),
                    BlocProvider<TrainingVideoBloc>(
                      create: (BuildContext context) => TrainingVideoBloc(),
                    ),
                    BlocProvider<LevelProfileBloc>(
                      create: (BuildContext context) => LevelProfileBloc(),
                    ),
                  ],
                  child: LevelScreen(
                    text: value.toString(),
                    id: _id,
                  ),
                );
              },
            )

          ],
        )
      ),
    );
  }
  Widget defaultUI(){
    return Column(
      children: [
        BlocBuilder<LeaderBoardBloc, LeaderBoardState>(
          builder: (context, state) {
            if (state is LeaderBoardLoading) {
              return Center(child: CircularProgressIndicator(color: AppColors.appColor,));
            } else if (state is LeaderBoardLoaded) {
              print("Loaded");
              final leadersData = state.leaderBoardResponse.data.leaders;
              return BlocBuilder<LeaderBoardBloc, LeaderBoardState>(
                builder: (context, state) {
                  if (state is LeaderBoardLoading) {
                    return Center(child: CircularProgressIndicator(color: AppColors.appColor,));
                  } else if (state is LeaderBoardLoaded) {
                    print("Loaded");
                    final leadersData = state.leaderBoardResponse.data.leaders;
                    return leadersData.length > 0?
                    BuildRankContainer(
                      point: leadersData[0].totalRewardPoints.toString(),

                      bottom: 0.008,
                      top: 0.068,
                      left: 0.028,
                      height: 248,
                      logoHeight: 105,
                      personImage: leadersData[0].user.media.isNotEmpty
                          ? leadersData[0].user.media[0].originalUrl
                          : '',
                      rankBackground: AppImages.rank1,
                      name: leadersData[0].user.firstName + leadersData[0].user.lastName,
                      isCrowned: true,
                    ):Container();
                  } else if (state is LeaderBoardError) {
                    return Center(child: Text('${state.errorMessage}'));
                  } else {
                    return Center(child: Text('Something Went Wrong'));
                  }
                },
              );
            } else if (state is LeaderBoardError) {
              return Center(child: Text('${state.errorMessage}'));
            } else {
              return Center(child: Text('Something Went Wrong'));
            }
          },
        ),

        Gridcomponent(selectedButton:GlobleValue.selectedButton.value.toString(), onRebuildParent:   _updateUI,),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocProvider<TrainingVideoBloc>(
              create: (context) => TrainingVideoBloc(),child: TrainingViewData()),
        ),
        LeaderBoard(
          padding: 0,
          scoreBool: true,
          onLevelSelected: (level) {
            print("Selected Level: $level");

            context.read<LeaderBoardBloc>().add(FetchLeaderBoard(level));
          },
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 00.0, vertical: 0),
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
    );
  }
  Widget TrainingViewData(){
    return  BlocBuilder<TrainingProgramBloc, TrainingProgramState>(
      builder: (context, state) {
        if (state is TrainingLoading) {
          return Center(child: CircularProgressIndicator(color: AppColors.appColor,));
        } else if (state is TrainingLoaded) {
          var data = state.trainingResponse.data;
          print("datadata:$data");

          return Container(
            child: TrainingView(
                unLockedData: data?.unlocked,
                lockedData: data?.locked),
          );
        } else if (state is TrainingError) {
          return Center(child: Text('${state.errorMessage}'));
        } else {
          return Center(child: Text('Something Went Wrong'));
        }
      },
    );
  }
  Widget TrainingView({List<Unlocked>? unLockedData, List<Locked>? lockedData}) {
    return Column(
      children: [

        VideoComponent(data:unLockedData, isUnlocked:true,text: 'beginner', onRebuildParent: _updateUI),
        VideoComponent(data:lockedData,isUnlocked: false,text: 'beginner',onRebuildParent: _updateUI,),
      ],
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (leaders.length > 1 )
              BuildRankContainer(
                point: leaders[1].totalRewardPoints.toString(),
                bottom: 20,
                top: 0.0020,
                left: 0.085,
                height: 170,
                logoHeight: 63,
                personImage: leaders[1].user.media.isNotEmpty
                    ? leaders[1].user.media.first.originalUrl
                    : '',
                rankBackground: AppImages.rank2,
                name: '${leaders[1].user.firstName} ${leaders[1].user.lastName}',
              ),
            if (leaders.isNotEmpty )
              BuildRankContainer(
                point: leaders[0].totalRewardPoints.toString(),

                bottom: 0.008,
                top: 0.068,
                left: 0.028,
                height: 248,
                logoHeight: 105,
                personImage: leaders[0].user.media.isNotEmpty
                    ? leaders[0].user.media.first.originalUrl
                    : '',
                rankBackground: AppImages.rank1,
                name: '${leaders[0].user.firstName} ${leaders[0].user.lastName}',
                isCrowned: true,
              ),
            if (leaders.length > 2 )
              BuildRankContainer(
                point: leaders[2].totalRewardPoints.toString(),

                bottom: 20,
                top: 0.0020,
                left: 0.085,
                height: 170,
                logoHeight: 63,
                personImage: leaders[2].user.media.isNotEmpty
                    ? leaders[2].user.media.first.originalUrl
                    : '',
                rankBackground: AppImages.rank3,
                name: '${leaders[2].user.firstName} ${leaders[2].user.lastName}',
              ),
          ],
        ),

      ],
    );
  }
  Widget _buildButton(String text, bool lock) {
    return ValueListenableBuilder<String>(
      valueListenable: GlobleValue.selectedButton,
      builder: (context, selectedButtonValue, child) {
        bool isSelected = selectedButtonValue == text;

        return InkWell(
          highlightColor: Colors.transparent, // Remove the highlight effect
          splashColor: Colors.transparent, // Remove the splash effect
          onTap: () => _updateUI(text),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3),
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.appColor // Change the color if selected
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? Colors.transparent : AppColors.whiteColor,
                width: 1,
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: AppTextStyles.athleticStyle(
                      fontSize: 12,
                      fontFamily: AppTextStyles.sfPro700,
                      color: isSelected
                          ? AppColors.whiteColor
                          : AppColors.whiteColor,
                    ),
                  ),
                  lock == true
                      ? AppImages.image(
                      AppImages.levelLock, height: 14, width: 14)
                      : SizedBox(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget _buildRankContainer(double bottom,double top,double left ,double height , double logoHeight,String personImage, String rankBackground,String name,{bool isCrowned = false}) {
    return   SizedBox(
      width: MediaQuery.of(context).size.width/3,
      height: height, // Adjust height according to your design
      child: Padding(
        padding:  EdgeInsets.only(bottom: bottom),
        child: Stack(
          children: [
            // Background container
            Positioned(
              // top: MediaQuery.of(context).size.height * 0.074,
              // left: MediaQuery.of(context).size.width * 3,
              top: MediaQuery.of(context).size.height * top,
              left: MediaQuery.of(context).size.width * left,

              child: AppImages.image(
                personImage,
                height: logoHeight,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned.fill(
              bottom: 25,
              child: Container(
                height: height,
                decoration: AppImages.background(rankBackground, fit: BoxFit.fitHeight),
              ),
            ),
            Positioned(
                bottom: isCrowned?MediaQuery.of(context).size.height*0.040:MediaQuery.of(context).size.height*0.036,
                right: isCrowned?MediaQuery.of(context).size.width*0.04:MediaQuery.of(context).size.width*0.07,
                child: Column(
                  children: [
                    Text("$name",style: AppTextStyles.athleticStyle(fontSize: 12, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor)),
                    Text("US 500 XP",style: AppTextStyles.athleticStyle(fontSize: 11, fontFamily: AppTextStyles.sfPro500, color: AppColors.whiteColor)),
                  ],
                ))
          ],
        ),
      ),
    );
  }

}
