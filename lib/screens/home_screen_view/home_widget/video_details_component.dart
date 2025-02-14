import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/screens/training_screen_view/training_bloc/training_program_state.dart';
import 'package:q_bounce/screens/training_screen_view/training_view_model/TrainingVideoResponse.dart';
import 'package:video_player/video_player.dart';

import '../../../app_services/common_Capital.dart';
import '../../../constant/app_color.dart';
import '../../../constant/app_images.dart';
import '../../../constant/app_text_style.dart';
import '../../training_screen_view/training_bloc/training_program_bloc.dart';
import '../../training_screen_view/training_bloc/training_program_event.dart';
import '../../training_screen_view/training_program_bloc/training_program_bloc.dart';
import '../../training_screen_view/training_program_bloc/training_program_event.dart';
import '../../training_screen_view/training_progress_bloc/training_progress_bloc.dart';
import '../../training_screen_view/training_progress_bloc/training_progress_event.dart';

class VideoDetailsComponent extends StatefulWidget {
  final int videoIndex;
  final Data? data;
  final String? text;
  final Function() onRebuildParent;  // Callback to notify the parent to rebuild

  const VideoDetailsComponent({super.key, required this.videoIndex, this.data, this.text, required this.onRebuildParent});

  @override
  State<VideoDetailsComponent> createState() => _VideoDetailsComponentState();
}

class _VideoDetailsComponentState extends State<VideoDetailsComponent> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool isVideoLoaded = false;
  bool isVideoPlaying = false;
  bool isLoading = false;

  final List<Map<String, dynamic>> videoDetails = [
    {
      "title": "Instructions :",
      "points": [
        "Repeat drills for 15 sec",
        "Rest 15 sec between rounds",
        "Choose your own tempo"
      ]
    },
    {
      "title": "Don’t forget:",
      "points": [
        "QBounce Master Training mat lines are a guide for understanding and learning drills. Focus on executing the correct move no matter the tempo."
      ]
    },
    {
      "title": "Extra Tip:",
      "points": [
        "Once you get a hang of the exercise try to lift your head and glance at the ball as little as possible."
      ]
    },
  ];

  final List<String> videoUrls = [
    'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
    'https://samplelib.com/lib/preview/mp4/sample-5s.mp4',
    'https://samplelib.com/lib/preview/mp4/sample-10s.mp4',
  ];

  final List<String> thumbnailUrls = [
    AppImages.appBackGround,
    AppImages.ballIcon,
    AppImages.howItGroup
  ];

  void _initializeVideo(int index) {
    setState(() {
      isLoading = true;
      isVideoPlaying = false;
      isVideoLoaded = false;
    });

    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose().then((_) {
        _startNewVideo(index);
      });
    } else {
      _startNewVideo(index);
    }
  }

  @override
  void initState() {
    _initializeVideo(widget.videoIndex);
    super.initState();
  }

  void _startNewVideo(int index) {
    _videoPlayerController = VideoPlayerController.network(widget.data!.videoUrl.toString())
      ..initialize().then((_) {
        setState(() {
          isLoading = false;
          isVideoLoaded = true;
        });

        _videoPlayerController!.addListener(() {
          if (_videoPlayerController!.value.position == _videoPlayerController!.value.duration) {
            // Video completed
            if (!isVideoCompleted) {
              print("Video completed");
              setState(() {
                isVideoCompleted = true;
              });

              // Fetch training progress
              context.read<TrainingProgressBloc>().add(
                FetchTrainingProgress({"trainingId": widget.data?.id}),
              );

              // Fetch new video data and trigger a rebuild
              context.read<TrainingVideoBloc>().add(
                FetchTrainingVideo(widget.data!.id!.toString()),
              );
              WidgetsBinding.instance.addPostFrameCallback((_) {
                // Call the parent callback to notify it to rebuild
                widget.onRebuildParent();
              });
            }
          }
        });

        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          autoPlay: false,
          looping: false,
          placeholder: Container(
            color: Colors.black87,
            child: Container(
              child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                    new AlwaysStoppedAnimation<Color>(AppColors.appColor),
                  )),
            ),
          ),

                  cupertinoProgressColors: ChewieProgressColors(backgroundColor: AppColors.unSelectedNav,bufferedColor: AppColors.appColor,handleColor: AppColors.appColor,playedColor: AppColors.appColor),
                  materialProgressColors:ChewieProgressColors(backgroundColor: AppColors.whiteColor,bufferedColor: AppColors.appColor,)
        );
      });
  }

  void _playVideo() {
    if (_videoPlayerController != null && isVideoLoaded) {
      setState(() {
        isVideoPlaying = true;
      });
      _videoPlayerController!.play();
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  bool isVideoCompleted = false;

    void _rebuildPage() {
      // Trigger the fetch event again to update data
      context.read<TrainingProgramBloc>().add(FetchTraining(widget.text.toString()));

      // Schedule the rebuild of the parent after the current frame is done
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Call the parent callback to notify it to rebuild
        widget.onRebuildParent();
      });
    }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<TrainingVideoBloc, TrainingVideoState>(
          builder: (context, state) {
            int? displayCount = isVideoCompleted ? GlobleValue.numericCount.value : widget.data?.count?.toInt();

            return Padding(
              padding: EdgeInsets.only(left: 0, right: 0, bottom: 25),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (!isVideoPlaying)
                            Image.network(
                              widget.data!.thumbnailUrl.toString(),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          if (isLoading) CircularProgressIndicator(color: Colors.white),
                          if (isVideoLoaded && !isVideoPlaying)
                            GestureDetector(
                              onTap: _playVideo,
                              child: Icon(Icons.play_circle_fill, size: 80, color: Colors.white),
                            ),
                          if (isVideoPlaying && _chewieController != null)
                            Chewie(controller: _chewieController!),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18.5),
                    decoration: BoxDecoration(
                      color: AppColors.appColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.data!.title.toString(),
                          style: AppTextStyles.athleticStyle(
                            fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor,
                          ),
                        ),
                        Text(
                          "${displayCount! >= 3 ? 3 : displayCount}/3",
                          style: AppTextStyles.athleticStyle(
                            fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18.5),
                    decoration: BoxDecoration(
                      color: AppColors.appColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "XP Reward Points",
                          style: AppTextStyles.athleticStyle(
                            fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor,
                          ),
                        ),
                        Text(
                          widget.data!.xp.toString(),
                          style: AppTextStyles.athleticStyle(
                            fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  detailsComponent(),
                ],
              ),
            );
          },
        ),
      ],
    );
  }



  Widget detailsComponent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.faq,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        itemCount: videoDetails.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                CommonCapital.capitalizeEachWord(
                    '${index + 1}. ${videoDetails[index]["title"]}'),
                style: AppTextStyles.athleticStyle(
                    fontSize: 12, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),
              ),
              SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  videoDetails[index]["points"].length,
                      (i) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "• ",
                        style: AppTextStyles.getOpenSansGoogleFont(18, AppColors.whiteColor, false),
                      ),
                      Expanded(
                        child: Text(
                          CommonCapital.capitalizeEachWord(
                              videoDetails[index]["points"][i]),
                          style: AppTextStyles.getOpenSansGoogleFont(10, AppColors.whiteColor, false),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

