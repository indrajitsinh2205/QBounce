import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/common_widget/common_tab_bar.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/screens/training_screen_view/training_bloc/training_program_bloc.dart';
import 'package:q_bounce/screens/training_screen_view/training_bloc/training_program_event.dart';
import 'package:q_bounce/screens/training_screen_view/training_bloc/training_program_state.dart';
import 'package:q_bounce/screens/training_screen_view/training_program_bloc/training_program_bloc.dart';
import 'package:q_bounce/screens/training_screen_view/training_program_bloc/training_program_event.dart';
import 'package:q_bounce/screens/training_screen_view/training_program_bloc/training_program_state.dart';
import 'package:q_bounce/screens/training_screen_view/training_progress_bloc/training_progress_bloc.dart';
import 'package:q_bounce/screens/training_screen_view/training_progress_bloc/training_progress_event.dart';
import 'package:q_bounce/screens/training_screen_view/training_progress_bloc/training_progress_state.dart';
import 'package:q_bounce/screens/training_screen_view/training_view_model/TrainingResponse.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ChewieController? _chewieController;
  VideoPlayerController? _videoPlayerController;
  bool isLoading = true;
  String? currentVideoId;
  bool showVideo = false;
  bool showThumbnail = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_onTabChanged);
    _fetchInitialTrainingData("beginner");
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      final trainingLevels = ["beginner", "advanced", "pro", "master"];
      final selectedLevel = trainingLevels[_tabController.index];

      setState(() {
        currentVideoId = null;
        showVideo = false;
        _videoPlayerController?.pause();
      });

      _fetchTrainingDataForTab(selectedLevel);
    }
  }

  void _fetchInitialTrainingData(String level) {
    context.read<TrainingProgramBloc>().add(FetchTraining(level));
  }

  void _fetchTrainingDataForTab(String level) {
    context.read<TrainingProgramBloc>().add(FetchTraining(level));
  }

  void initializeVideoPlayer(String videoUrl , String videoId) {
    if (_videoPlayerController == null || _videoPlayerController?.dataSource != videoUrl) {
      _videoPlayerController = VideoPlayerController.network(videoUrl);

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: false,
        showControls: true,
        // customControls: ChewieCustomControls( videoPlayerController:_videoPlayerController,),
      );

      _videoPlayerController?.initialize().then((_) {
        setState(() {
          isLoading = false;
        });
      }).catchError((error) {
        setState(() {
          isLoading = false;
        });
        print("Error initializing video: $error");
      });
// _videoPlayerController?.play();


      _videoPlayerController?.addListener(() {
        if (_videoPlayerController?.value.isPlaying == true && showThumbnail) {
          setState(() {
            showThumbnail = false;
          });
        }
        if (_videoPlayerController?.value.position == _videoPlayerController?.value.duration) {
          context.read<TrainingProgressBloc>().add(FetchTrainingProgress({"trainingId": videoId}));
          context.read<TrainingProgressBloc>().stream.listen((state) {
            if (state is TrainingProgressLoaded) {
              // Second API call after the first one is successful
              final trainingLevels = ["beginner", "advanced", "pro", "master"];

              final selectedLevel = trainingLevels[_tabController.index];
              _fetchTrainingDataForTab(selectedLevel);

            } else if (state is TrainingProgressError) {
              // Handle error if needed
              print("Error fetching training progress");
            }
        });}
      });
    }
  }

  void togglePlayPause() {
    if (_videoPlayerController?.value.isPlaying == true) {
      _videoPlayerController?.pause();
    } else {
      _videoPlayerController?.play();
    }
    setState(() {}); // Only update the UI
  }


  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
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
              tabTitles: ["Beginner", "Advanced", "Pro", "Master"],
              Box: true,
              controller: _tabController,
            ),
            Expanded(
              child: BlocBuilder<TrainingProgramBloc, TrainingProgramState>(
                builder: (context, state) {
                  if (state is TrainingLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is TrainingLoaded) {
                    var data = state.trainingResponse.data;

                    if (data?.unlocked.isEmpty == true) {
                      showVideo = false;
                    } else {
                      showVideo = true;
                    }

                    if (data?.unlocked.isNotEmpty == true && data!.unlocked.first.id != null) {
                      currentVideoId = data.unlocked.first.id.toString();
                      context.read<TrainingVideoBloc>().add(FetchTrainingVideo(currentVideoId!));
                    }

                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 4 * 1.35,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              TrainingView(
                                  unLockedData: data?.unlocked,
                                  lockedData: data?.locked),
                              TrainingView(
                                  unLockedData: data?.unlocked,
                                  lockedData: data?.locked),
                              TrainingView(
                                  unLockedData: data?.unlocked,
                                  lockedData: data?.locked),
                              TrainingView(
                                  unLockedData: data?.unlocked,
                                  lockedData: data?.locked),
                            ],
                          ),
                        ),
                        if (showVideo) ...[
                          BlocBuilder<TrainingVideoBloc, TrainingVideoState>(
                            builder: (context, videoState) {
                              if (videoState is TrainingVideoLoading) {
                                return Center(child: CircularProgressIndicator());
                              } else if (videoState is TrainingVideoLoaded) {
                                var videoData = videoState.trainingVideoResponse.data;
                                if (videoData != null && videoData.videoUrl != null) {
                                  if (_videoPlayerController == null || _videoPlayerController!.dataSource != videoData.videoUrl) {
                                    initializeVideoPlayer(videoData.videoUrl!, videoData.id.toString());
                                  }
                                }
                                return VideoView(videoData!.count.toString(), videoData.thumbnailUrl.toString(),videoData.categoryName.toString());
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
            ),
          ],
        ),
      ),
    );
  }

  Widget TrainingView({List<Unlocked>? unLockedData, List<Locked>? lockedData}) {
    return Column(
      children: [
        _buildListView(unLockedData, true),
        _buildListView(lockedData, false),
      ],
    );
  }

  Widget _buildListView(List<dynamic>? data, bool isUnlocked) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data?.length ?? 0,
      itemBuilder: (context, index) {
        final item = data?[index];
        return InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () {
            if (isUnlocked) {
              _videoPlayerController?.pause();
              currentVideoId = item.id.toString();
              context.read<TrainingVideoBloc>().add(FetchTrainingVideo(currentVideoId!));
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.whiteColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isUnlocked)
                  Icon(Icons.lock_clock_outlined, color: Colors.white),
                if (!isUnlocked) SizedBox(width: 5),
                Text(item.title, style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget VideoView(String count, String thumbUrl, String categoryName) {
    int numericCount = int.tryParse(count) ?? 0;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              if (_chewieController != null && _chewieController!.videoPlayerController.value.isInitialized)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_chewieController!.videoPlayerController.value.isPlaying) {
                        _chewieController!.videoPlayerController.pause();
                      } else {
                        _chewieController!.videoPlayerController.play();
                      }
                    });
                  },
                  child: AspectRatio(
                    aspectRatio: _chewieController!.videoPlayerController.value.aspectRatio,
                    child: Chewie(controller: _chewieController!),
                  ),
                ),

              if (showThumbnail)
                Positioned.fill(
                  child: Container(
                    color: Colors.black,
                    child: Image.network(
                      thumbUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),

              if (isLoading)
                const Center(child: CircularProgressIndicator()),

              if (_chewieController != null && _chewieController!.videoPlayerController.value.isInitialized && !_chewieController!.videoPlayerController.value.isPlaying)
                Positioned(
                  child: IconButton(
                    icon: Icon(
                      _chewieController!.videoPlayerController.value.isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      size: 50,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_chewieController!.videoPlayerController.value.isPlaying) {
                          _chewieController!.videoPlayerController.pause();
                        } else {
                          _chewieController!.videoPlayerController.play();
                        }
                      });
                    },
                  ),
                ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(categoryName, style: TextStyle(color: Colors.white,fontSize: 20)),
                Text(
                  "${numericCount >= 3 ? 3 : numericCount}/3",
                  style: TextStyle(color: Colors.white,fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChewieCustomControls extends StatefulWidget {
    final VideoPlayerController? videoPlayerController;
    ChewieCustomControls({required this.videoPlayerController});

    @override
  State<ChewieCustomControls> createState() => _ChewieCustomControlsState();
}

class _ChewieCustomControlsState extends State<ChewieCustomControls> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: Icon(
          widget.videoPlayerController!.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
        ),
        onPressed: () {
          if (widget.videoPlayerController!.value.isPlaying) {
            widget.videoPlayerController!.pause();
          } else {
            widget.videoPlayerController!.play();
          }
        },
      ),
    );
  }
}
