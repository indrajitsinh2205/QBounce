import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_bounce/screens/training_screen_view/training_view_model/TrainingVideoResponse.dart';
import 'package:video_player/video_player.dart';

import '../../../app_services/common_Capital.dart';
import '../../../constant/app_color.dart';
import '../../../constant/app_images.dart';
import '../../../constant/app_text_style.dart';

class VideoDetailsComponent extends StatefulWidget {
  final int videoIndex;
  final Data? data;
  const VideoDetailsComponent({super.key, required this.videoIndex, this.data});

  @override
  State<VideoDetailsComponent> createState() => _VideoDetailsComponentState();
}

class _VideoDetailsComponentState extends State<VideoDetailsComponent> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool isVideoLoaded = false;
  bool isVideoPlaying = false;
  bool isLoading = false;
  final List<Map<String, dynamic>> videoDetails  = [
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


  // int currentVideoIndex = widget.videoIndex;

  void _initializeVideo(int index) {
    setState(() {
      isLoading = true;
      isVideoPlaying = false;
      // currentVideoIndex = index;
      isVideoLoaded = false;
    });

    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose().then((_) {
        _startNewVideo(index);
      });
    }/* else {
      _startNewVideo(index);
    }*/
  }
  @override
  void initState() {
    // TODO: implement initState
    _initializeVideo(widget.videoIndex);

    super.initState();
  }

  void _startNewVideo(int index) {
    _videoPlayerController = VideoPlayerController.network(widget.data!.videoUrl.toString())
      ..initialize().then((_) {
        setState(() {
          isLoading = false;
          isVideoLoaded = true; // Video is loaded but not playing yet
        });
        _videoPlayerController!.addListener(() {
          if (_videoPlayerController!.value.position == _videoPlayerController!.value.duration) {
            // Video has completed
            print("Video completed");

            // You can print any value or trigger other actions here
          }
        });
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          autoPlay: false, // Do not auto-play
          looping: false,
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
  @override
  Widget build(BuildContext context) {
    print("widget.videoIndex ${widget.videoIndex}");
    int numericCount = int.tryParse(widget.data!.count.toString()) ?? 0;
    return Padding(padding: EdgeInsets.only(left: 0,right: 0,bottom: 25),
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
                if (isLoading)
                  CircularProgressIndicator(color: Colors.white),
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
        padding: EdgeInsets.symmetric(horizontal:  25,vertical:  18.5),
        decoration: BoxDecoration(
            color: AppColors.appColor,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text(
              widget.data!.categoryName.toString(),style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),
            Text("${numericCount >= 3 ? 3 : numericCount}/3",style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),
          ],
        ),
      ),
      SizedBox(height: 15,),
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal:  25,vertical:  18.5),
        decoration: BoxDecoration(
            color: AppColors.faq,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("XP Reward Points",style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),
            Text(widget.data!.xp.toString(),style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),

          ],
        ),
      ),
        detailsComponent()
      ],
    ),
    );
  }

  Widget detailsComponent (){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.all( 20),
      decoration: BoxDecoration(
        color: AppColors.faq,
        borderRadius: BorderRadius.circular(8)
      ),
      child: ListView.builder(
        itemCount: videoDetails.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 15),
              Text(CommonCapital.capitalizeEachWord(
                  '${index + 1}. ${videoDetails[index]["title"]}'),
                  style:AppTextStyles.athleticStyle(fontSize: 12, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor)
              ),
              const SizedBox(height: 5),
      
              // Bullet Points
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  videoDetails[index]["points"].length,
                      (i) => Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        "• ", // Bullet symbol
                        style:  AppTextStyles.getOpenSansGoogleFont(18, AppColors.whiteColor, false),
                      ),
                      Expanded(
                        child: Text(
                          CommonCapital.capitalizeEachWord(
                          videoDetails[index]["points"][i]),
                          style:  AppTextStyles.getOpenSansGoogleFont(10, AppColors.whiteColor, false),
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
