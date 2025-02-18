

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/constant/app_images.dart';
import 'package:q_bounce/screens/home_screen_view/get_level_profile_bloc/get_level_profile_bloc.dart';
import 'package:q_bounce/screens/home_screen_view/get_level_profile_bloc/get_level_profile_event.dart';
import 'package:q_bounce/screens/home_screen_view/home_widget/video_component.dart';
import 'package:q_bounce/screens/home_screen_view/home_widget/video_details_component.dart';

import '../../constant/app_color.dart';
import '../../constant/app_strings.dart';
import '../../constant/app_text_style.dart';
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
  final String text ;
  final String? id ;
  const LevelScreen({super.key, required this.text, required, this.id ,});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  String? currentVideoId;
  bool showVideo = false;
  bool isWidgetIdUsed = false;

  // Create a cache for the level data
  Map<String, LevelData> levelDataCache = {};

  @override
  void initState() {
    super.initState();
    _fetchLevelProfile();
  }

  void _fetchLevelProfile() {
    if (!levelDataCache.containsKey(widget.text)) {
      // Fetch the data if it hasn't been fetched yet
      context.read<LevelProfileBloc>().add(FetchLevelProfile());
    } else {
      // Use the cached data if available
      setState(() {
        var cachedData = levelDataCache[widget.text];
        if (cachedData != null) {
          // Do something with cached data, or trigger UI update
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<TrainingProgramBloc>().add(FetchTraining(widget.text));

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(height: 30),
          BlocBuilder<LevelProfileBloc, LevelProfileState>(
            builder: (context, state) {
              if (state is LevelProfileLoading) {
                return Center(child: CircularProgressIndicator(color: AppColors.appColor));
              } else if (state is LevelProfileLoaded) {
                var levelData = state.getLevelProfileResponse.data;
                if (levelData == null) {
                  return Center(child: Text(AppStrings.noSTData));
                }

                // Cache the level data for future use
                levelDataCache[widget.text] = levelData;

                return levelProfile(levelData);
              } else if (state is LevelProfileError) {
                return Center(child: Text(state.errorMessage, style: TextStyle(color: Colors.red)));
              } else {
                return Center(child: Text(AppStrings.somethingW));
              }
            },
          ),
          BlocBuilder<TrainingProgramBloc, TrainingProgramState>(
            builder: (context, state) {
              if (state is TrainingLoading) {
                return Center(child: CircularProgressIndicator(color: AppColors.appColor));
              } else if (state is TrainingLoaded) {
                var data = state.trainingResponse.data;
                if (data?.unlocked?.isEmpty == true) {
                  showVideo = false;
                } else {
                  showVideo = true;
                }

                if (data?.unlocked?.isNotEmpty == true) {
                  if (!isWidgetIdUsed && widget.id != null) {
                    currentVideoId = widget.id; // Use widget.id only once
                    isWidgetIdUsed = true;
                  } else {
                    currentVideoId = data!.unlocked!.first.id.toString(); // Use first.id for subsequent changes
                  }
                  context.read<TrainingVideoBloc>().add(FetchTrainingVideo(currentVideoId!));
                }

                return Column(
                  children: [
                    Container(
                      child: TrainingView(
                          unLockedData: data?.unlocked, lockedData: data?.locked),
                    ),
                    if (showVideo) ...[
                      BlocBuilder<TrainingVideoBloc, TrainingVideoState>(
                        builder: (context, videoState) {
                          if (videoState is TrainingVideoLoading) {
                            return Center(child: CircularProgressIndicator(color: AppColors.appColor));
                          } else if (videoState is TrainingVideoLoaded) {
                            var videoData = videoState.trainingVideoResponse.data;
                            return MultiBlocProvider(
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
                              child: VideoDetailsComponent(
                                  videoIndex: data!.currentVideoId!.toInt(),
                                  data: videoData,
                                  text: widget.text,
                                  onRebuildParent: () {
                                    setState(() {

                                    });
                                  },),
                            );
                          } else if (videoState is TrainingVideoError) {
                            return Center(child: Text('${videoState.errorMessage}'));
                          } else {
                            return Center(child: Text('Something Went Wrong'));
                          }
                        },
                      ),
                    ]
                  ],
                );
              } else if (state is TrainingError) {
                return Center(child: Text('${state.errorMessage}'));
              } else {
                return Center(child: Text('Something Went Wrong'));
              }
            },
          ),
        ],
      ),
    );
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
                    style: AppTextStyles.athleticStyle(fontSize: 18, fontFamily: AppTextStyles.sfUi700, color: AppColors.whiteColor),
                  ),
                  Text(
                    "#${levelData.id}",
                    style: AppTextStyles.athleticStyle(fontSize: 18, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),
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
                    child: Image.network(levelData.image.toString(), height: 75, width: 75),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${levelData.firstName != 'null' ?levelData.firstName:""} ${levelData.lastName!= 'null' ?levelData.lastName:''}",
                          style: AppTextStyles.athleticStyle(fontSize: 18, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor)),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: (index < levelData.stars!.toInt()) ? Colors.yellow : Colors.white,
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
                              style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w800),
                            ),
                            Text(
                              item['point'] == "null" || item['point'] == null
                                  ? "0"
                                  : (double.tryParse(item['point']!) != null
                                  ? (double.parse(item['point']!) / 100000).toStringAsFixed(1)
                                  : "0"),
                              style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
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

  Widget TrainingView({List<Unlocked>? unLockedData, List<Locked>? lockedData}) {
    return Column(
      children: [
        // _buildListView(unLockedData, true),
        // _buildListView(lockedData, false),
        VideoComponent(data:unLockedData, isUnlocked:true,text: widget.text,id: widget.id,),
        VideoComponent(data:lockedData,isUnlocked: false,text: widget.text,),
      ],
    );
  }
}
