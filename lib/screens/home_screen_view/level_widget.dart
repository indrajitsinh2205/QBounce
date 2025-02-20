import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/constant/app_images.dart';
import 'package:q_bounce/screens/home_screen_view/get_level_profile_bloc/get_level_profile_bloc.dart';
import 'package:q_bounce/screens/home_screen_view/get_level_profile_bloc/get_level_profile_event.dart';
import 'package:q_bounce/screens/home_screen_view/home_widget/video_component.dart';
import 'package:q_bounce/screens/home_screen_view/home_widget/video_details_component.dart';
import 'package:q_bounce/screens/training_screen_view/training_view_model/TrainingVideoResponse.dart';

import '../../constant/app_color.dart';
import '../../constant/app_strings.dart';
import '../../constant/app_text_style.dart';
import '../profile_screen_view/profile_singleton.dart';
import '../training_screen_view/training_bloc/training_program_bloc.dart';
import '../training_screen_view/training_bloc/training_program_event.dart';
import '../training_screen_view/training_bloc/training_program_state.dart';
import '../training_screen_view/training_program_bloc/training_program_bloc.dart';
import '../training_screen_view/training_program_bloc/training_program_event.dart';
import '../training_screen_view/training_program_bloc/training_program_state.dart';
import '../training_screen_view/training_progress_bloc/training_progress_bloc.dart';
import '../training_screen_view/training_view_model/TrainingResponse.dart';
import 'get_level_profile_bloc/get_level_profile_state.dart';
import 'get_level_profile_view_model/get_level_profile_response.dart';

class LevelScreen extends StatefulWidget {

  final String text;
  final String? id;

  final List<Unlocked>? unlocked;
  final List<Locked>? locked;

  const LevelScreen({
  super.key,
  required this.text,
  required,
  this.id,
  this.unlocked,
  this.locked,
});

@override
State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  String? currentVideoId;
  bool showVideo = false;
  bool isWidgetIdUsed = false;

  bool isLoading = false;
  bool isLoadingFromWidgetBuilder = false;
  String errorMessage = "";

  GetLevelProfileResponse? levelData;
  TrainingResponse? trainingData;
  TrainingVideoResponse? videoResponse;

  @override
  void initState() {
    super.initState();
    context.read<LevelProfileBloc>().add(FetchLevelProfile());

  }


  void _fetchInitialData() async {
    // if (isLoadingFromWidgetBuilder) return;
    // isLoadingFromWidgetBuilder = true;

    // isLoading = true;
    var type = widget.text;
    levelData = await LevelModuleDataHandler.instance.levelData;
    trainingData =
    await LevelModuleDataHandler.instance.fetchTrainingData(type);

    if (levelData?.data == null) {
      // Fetch the data if it hasn't been fetched yet
      context.read<LevelProfileBloc>().add(FetchLevelProfile());
    }
    if (trainingData == null) {
      // Fetch the data if it hasn't been fetched yet
      context.read<TrainingProgramBloc>().add(FetchTraining(widget.text));
    }
    if (videoResponse == null) {
      // Fetch the data if it hasn't been fetched yet
      if (trainingData?.data?.unlocked?.isNotEmpty == true) {
        if (!isWidgetIdUsed && widget.id != null) {
          currentVideoId = widget.id; // Use widget.id only once
          isWidgetIdUsed = true;
        } else {
          currentVideoId = trainingData?.data?.unlocked!.first.id
              .toString(); // Use first.id for subsequent changes
        }
      }
      context.read<TrainingVideoBloc>().add(FetchTrainingVideo(currentVideoId!));
    }

    // print('Level Data for type : $type :${levelData?.firstName}');
    print('Training Data for type : $type :${trainingData?.data?.category}');
    // print('VideoData Data for type : $type :${vide?.data?.category}');

    setState(() {
      isLoading = false;
    });

    // isLoadingFromWidgetBuilder = false;

  }

  @override
  Widget build(BuildContext context) {

    _fetchInitialData();


    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Column(
            children: [

              SizedBox(height: 30),
               BlocBuilder<LevelProfileBloc, LevelProfileState>(
                builder: (context, state) {
                  if (state is LevelProfileLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: AppColors.appColor));
                  } else if (state is LevelProfileLoaded) {
                    var levelData = state.getLevelProfileResponse.data;
                    if (levelData == null) {
                      return Center(child: Text(AppStrings.noSTData));
                    }

                    // Cache the level data for future use
                    // levelDataCache[widget.text] = levelData;

                    return levelProfile(levelData);
                  } else if (state is LevelProfileError) {
                    return Center(
                        child: Text(state.errorMessage,
                            style: TextStyle(color: Colors.red)));
                  } else {
                    return Center(child: Text(AppStrings.somethingW));
                  }
                },
              ),
              Container(
                child: /*trainingData?.data==null ?
                CircularProgressIndicator(color: AppColors.appColor,) :*/
                TrainingView(
                  unLockedData: widget.unlocked ?? trainingData?.data?.unlocked,
                  lockedData: widget.locked ?? trainingData?.data?.locked,
                ),
              ),
              MultiBlocProvider(
                  providers: [
                    BlocProvider<TrainingProgressBloc>(
                      create: (context) => TrainingProgressBloc(),
                    ),
                    BlocProvider<TrainingVideoBloc>(
                      create: (context) => TrainingVideoBloc(),
                    ),
                    BlocProvider<TrainingProgramBloc>(
                      create: (context) => TrainingProgramBloc(),
                    ),
                  ],
                  child:

                  videoResponse==null?Container():
                  VideoDetailsComponent(
                      videoIndex: videoResponse!.data!.id!.toInt(),
                      data: videoResponse?.data,
                      text: widget.text,
                      onRebuildParent: () {
                        setState(() {});
                      })),
              // MultiBlocProvider(
              //   providers: [
              //     BlocProvider<TrainingProgressBloc>(
              //       create: (context) => TrainingProgressBloc(),
              //     ),
              //     BlocProvider<TrainingVideoBloc>(
              //       create: (context) => TrainingVideoBloc(),
              //     ),
              //     BlocProvider<TrainingProgramBloc>(
              //       create: (context) => TrainingProgramBloc(),
              //     ),
              //   ],
              //   child: VideoDetailsComponent(
              //     videoIndex: trainingData.data.category!.currentVideoId!.toInt(),
              //     data: videoData,
              //     text: widget.text,
              //     onRebuildParent: () {
              //       setState(() {
              //
              //       });
              //     },),
              // )

            ],
          ),
        ]));
  }

  Widget levelProfile(LevelData levelData) {
    List<Map<String, String>> stateData = [
      {"name": "PTS", "point": levelData.averagePointsScored.toString()},
      {"name": "REB", "point": levelData.averageRebounds.toString()},
      {"name": "AST", "point": levelData.averageAssists.toString()},
      {"name": "STL", "point": levelData.averageSteals.toString()},
      {"name": "BLK", "point": levelData.averageBlockedShots.toString()},
    ];

    return BlocProvider<LevelProfileBloc>(
      create: (context) => LevelProfileBloc(),
      child: Container(
        color: Color(0xFF333333),
        child: Column(
          children: [
            Container(
              color: Color(0xFFD74B16),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Player",
                    style: AppTextStyles.athleticStyle(
                        fontSize: 18,
                        fontFamily: AppTextStyles.sfUi700,
                        color: AppColors.whiteColor),
                  ),
                  Text(
                    "#${levelData.id}",
                    style: AppTextStyles.athleticStyle(
                        fontSize: 18,
                        fontFamily: AppTextStyles.sfPro700,
                        color: AppColors.whiteColor),
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFF333333),
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xFFD74B16), width: 2),
                    ),
                    child: levelData.image == null || levelData.image != 'null'
                        ? AppImages.image("assets/images/placeholder.jpg",
                        height: 75, width: 75, fit: BoxFit.cover)
                        : CachedNetworkImage(
                      imageUrl: levelData.image.toString(),
                      fadeInCurve: Curves.linear,
                      fadeOutCurve: Curves.linear,
                      fadeInDuration: Duration(microseconds: 0),
                      fadeOutDuration: Duration(microseconds: 0),
                      fit: BoxFit.cover,
                      height: 75,
                      width: 75,
                      placeholder: (BuildContext context, String url) =>
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: AppColors.appColor,
                                strokeWidth: 1,
                              ),
                            ),
                          ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${levelData.firstName != 'null' ? levelData.firstName : ""} ${levelData.lastName != 'null' ? levelData.lastName : ''}",
                          style: AppTextStyles.athleticStyle(
                              fontSize: 18,
                              fontFamily: AppTextStyles.sfPro700,
                              color: AppColors.whiteColor)),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: (index < levelData.stars!.toInt())
                                ? Colors.yellow
                                : Colors.white,
                          );
                        }),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: Color(0xFFD74B16), height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var item in stateData)
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 19.27),
                      child: Container(
                        height: 56.46,
                        width: 52.45,
                        decoration: AppImages.background(AppImages.levelFrame),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              item['name']!,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              item['point'] == "null" || item['point'] == null
                                  ? "0"
                                  : (double.tryParse(item['point']!) != null
                                  ? (double.parse(item['point']!) / 100000)
                                  .toStringAsFixed(1)
                                  : "0"),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 2),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget TrainingView(
      {List<Unlocked>? unLockedData, List<Locked>? lockedData}) {
    return Column(
      children: [
        // _buildListView(unLockedData, true),
        // _buildListView(lockedData, false),
        VideoComponent(
          data: unLockedData,
          isUnlocked: true,
          text: widget.text,
          id: widget.id,
        ),
        VideoComponent(
          data: lockedData,
          isUnlocked: false,
          text: widget.text,
        ),
      ],
    );
  }

  Future<List<Map<String, String>>> fetchCategoryDataFromApi(
      String category) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay

    // Return dummy data for demonstration (replace with your actual API response)
    return List.generate(5, (index) {
      return {
        "title": "$category Item ${index + 1}",
        "description": "Description for $category Item ${index + 1}",
      };
    });
  }

}

