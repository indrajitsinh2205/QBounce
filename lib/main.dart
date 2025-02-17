import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_images.dart';
import 'package:q_bounce/screens/profile_screen_view/profile_singleton.dart';
import 'package:video_player/video_player.dart';

import 'app_services/global_image_manager.dart';
import 'app_services/navigation_service.dart';
import 'common_widget/custom_snackbar.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final globalImageManager = GlobalImageManager();
  await globalImageManager.loadProfileImage();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProfileNotifier()),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: ScaffoldMessengerHelper.scaffoldMessengerKey, // Set the key here
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: NavigationService.generateRoute,
      initialRoute: '/',
      theme: Theme.of(context).copyWith(colorScheme: ColorScheme(
        primary: Colors.red, brightness: Brightness.light, onPrimary: AppColors.appColor, secondary: AppColors.appColor, onSecondary: AppColors.appColor, error: AppColors.appColor, onError: AppColors.appColor, surface: AppColors.appColor, onSurface: AppColors.appColor,
        // You should set other properties too
      )),
      debugShowCheckedModeBanner: false,
    );
  }
}


class VideoSwitcherPage extends StatefulWidget {
  @override
  _VideoSwitcherPageState createState() => _VideoSwitcherPageState();
}

class _VideoSwitcherPageState extends State<VideoSwitcherPage> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool isVideoLoaded = false;
  bool isVideoPlaying = false;
  bool isLoading = false;

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


  int currentVideoIndex = -1;

  void _initializeVideo(int index) {
    setState(() {
      isLoading = true;
      isVideoPlaying = false;
      currentVideoIndex = index;
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

  void _startNewVideo(int index) {
    _videoPlayerController = VideoPlayerController.network(videoUrls[index])
      ..initialize().then((_) {
        setState(() {
          isLoading = false;
          isVideoLoaded = true; // Video is loaded but not playing yet
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
    return Scaffold(
      appBar: AppBar(title: Text("Video Switcher")),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (!isVideoPlaying)
                  Image.asset(
                    currentVideoIndex == -1
                        ? AppImages.drawerBG
                        : thumbnailUrls[currentVideoIndex],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                if (isLoading)
                  CircularProgressIndicator(color: AppColors.appColor),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              videoUrls.length,
                  (index) => ElevatedButton(
                onPressed: () => _initializeVideo(index),
                child: Text("Load Video ${index + 1}"),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
