

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/constant/app_images.dart';
import 'package:q_bounce/screens/home_screen_view/get_level_profile_bloc/get_level_profile_bloc.dart';
import 'package:q_bounce/screens/home_screen_view/get_level_profile_bloc/get_level_profile_event.dart';
import 'package:q_bounce/screens/home_screen_view/home_widget/video_component.dart';
import 'package:q_bounce/screens/home_screen_view/home_widget/video_details_component.dart';
import 'package:video_player/video_player.dart';

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
  const LevelScreen({super.key, required this.text,});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  String? currentVideoId;
  bool showVideo = false;
  @override
  void initState() {
    // TODO: implement initState
    _fetchLevelProfile();
    super.initState();
  }
  void _fetchLevelProfile() {
    context.read<LevelProfileBloc>().add(FetchLevelProfile());
  }
  void _rebuildParent() {
    setState(() {
      // This will trigger a rebuild of the parent widget
    });
  }
  @override
  Widget build(BuildContext context) {
    context.read<TrainingProgramBloc>().add(FetchTraining(widget.text));


    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [

          SizedBox(height: 30,),
          BlocBuilder<LevelProfileBloc, LevelProfileState>(
            builder: (context, state) {
              if (state is LevelProfileLoading) {
                return Center(child: CircularProgressIndicator(color: AppColors.appColor,));
              } else if (state is LevelProfileLoaded) {
                Object leveldata = state.getLevelProfileResponse.data ?? LevelData(); // replace with appropriate default
                if (leveldata == null ) {
                  return Center(child: Text(AppStrings.noSTData));
                }
                return levelProfile(state.getLevelProfileResponse.data ?? LevelData());

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
                return Center(child: CircularProgressIndicator(color: AppColors.appColor,));
              } else if (state is TrainingLoaded) {
                var data = state.trainingResponse.data;
                if (data?.unlocked?.isEmpty == true) {
                  showVideo = false;
                } else {
                  showVideo = true;
                }

                if (data?.unlocked?.isNotEmpty == true && data!.unlocked?.first.id != null) {
                  currentVideoId = data.unlocked?.first.id.toString();
                  context.read<TrainingVideoBloc>().add(FetchTrainingVideo(currentVideoId!));
                }

                return Column(
                  children: [
                    Container(
                      // height: MediaQuery.of(context).size.height / 4 * 1.35,
                      child: TrainingView(
                          unLockedData: data?.unlocked,
                          lockedData: data?.locked),
                    ),
                    if (showVideo) ...[
                      BlocBuilder<TrainingVideoBloc, TrainingVideoState>(
                        builder: (context, videoState) {
                          if (videoState is TrainingVideoLoading) {
                            return Center(child: CircularProgressIndicator(color: AppColors.appColor,));
                          } else if (videoState is TrainingVideoLoaded) {
                            var videoData = videoState.trainingVideoResponse.data;
                            // if (videoData != null && videoData.videoUrl != null) {
                            //   if (_videoPlayerController == null || _videoPlayerController!.dataSource != videoData.videoUrl) {
                            //     initializeVideoPlayer(videoData.videoUrl!, videoData.id.toString());
                            //   }
                            // }
                            return  MultiBlocProvider(
                               providers: [
                            BlocProvider<TrainingProgressBloc>(
                            create: (context) => TrainingProgressBloc(),),
                                 BlocProvider<TrainingVideoBloc>(
                            create: (context) => TrainingVideoBloc(),),
                                 BlocProvider<TrainingProgramBloc>(
                            create: (context) => TrainingProgramBloc(),),
                               ],
                                child: VideoDetailsComponent(videoIndex:data!.currentVideoId!.toInt(),data:videoData,text: widget.text, onRebuildParent: _rebuildParent,));

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
          // VideoDetailsComponent(videoPlayerController: widget.videoPlayerController,)
        ],
      ),
    );
  }
  Widget TrainingView({List<Unlocked>? unLockedData, List<Locked>? lockedData}) {
    return Column(
      children: [
        // _buildListView(unLockedData, true),
        // _buildListView(lockedData, false),
        VideoComponent(data:unLockedData, isUnlocked:true,text: widget.text,),
        VideoComponent(data:lockedData,isUnlocked: false,text: widget.text,),
      ],
    );
  }
 Widget levelProfile(LevelData levelData){
    print("levelData.image ${levelData.image}");
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
              color:Color(0xFFD74B16),
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 14),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("My Player",style: AppTextStyles.athleticStyle(fontSize: 18, fontFamily: AppTextStyles.sfUi700, color: AppColors.whiteColor),),
                  Text("#${levelData.id}",style: AppTextStyles.athleticStyle(fontSize: 18, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),

                ],
              ),
            ),
            Container(
              color: Color(0xFF333333),
              padding: EdgeInsets.only(left: 20,top: 10,bottom: 10),
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xFFD74B16),width: 2)
                      ),
                      child:
                     Image.network(levelData.image.toString(),height: 75,width: 75)
                    // Image.asset("assets/ball.png",height: 75,width: 75,),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${levelData.firstName} ${levelData.lastName}",style: AppTextStyles.athleticStyle(fontSize: 18, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),
                      Row(
                        children: List.generate(5, (index) {
                          // Check if levelData.stars matches the index for yellow color
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
            Divider(
              color: Color(0xFFD74B16),
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space between items
                children: [

                  for (var item in stateData)
                    Container(
                      // height: 33,
                      padding: EdgeInsets.symmetric(vertical: 19.27), // Optional padding inside each item
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
                              style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: 	FontWeight.w700),
                            ),
                            SizedBox(height: 2,)
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget _buildListView(List<dynamic>? data, bool isUnlocked) {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     itemCount: data?.length ?? 0,
  //     itemBuilder: (context, index) {
  //       final item = data?[index];
  //       return VideoComponent();/*InkWell(
  //         splashFactory: NoSplash.splashFactory,
  //         // onTap: () {
  //         //   if (isUnlocked) {
  //         //     _videoPlayerController?.pause();
  //         //     currentVideoId = item.id.toString();
  //         //     context.read<TrainingVideoBloc>().add(FetchTrainingVideo(currentVideoId!));
  //         //   }
  //         // },
  //         child: Container(
  //           margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //           height: 50,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(color: AppColors.whiteColor),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               if (!isUnlocked)
  //                 Icon(Icons.lock_clock_outlined, color: Colors.white),
  //               if (!isUnlocked) SizedBox(width: 5),
  //               Text(item.title, style: TextStyle(color: Colors.white)),
  //             ],
  //           ),
  //         ),
  //       );*/
  //     },
  //   );
  // }
}
