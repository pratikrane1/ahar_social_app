import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:aharconnect/screen/home/widget/videoSlider.dart';
import 'package:aharconnect/utils/images.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class GalleryVideoScreen extends StatefulWidget {
  VideoModel? videData;
  GalleryVideoScreen({Key? key, required this.videData}) : super(key: key);

  @override
  _GalleryVideoScreenState createState() => _GalleryVideoScreenState();
}

class _GalleryVideoScreenState extends State<GalleryVideoScreen> {
  TargetPlatform? _platform;

  YoutubePlayerController? _ytbPlayerController;
  PageController? _pageController;
  int activePage = 1;
  bool _fullScreen = false;
  String? videoId = "";
  String? descriptionText = "Description: Welcome to the world of Destek Infosolutions Private Limited, a trailblazing IT services and products company that is revolutionizing businesses through digital transformation. With an extensive portfolio of successful projects and a talented team of over 250 experts, Destek is at the forefront of driving innovation and reshaping the way organizations harness the power of technology.Join us on an awe-inspiring journey as we unveil the exceptional story of Destek, showcasing our unwavering commitment to empowering businesses worldwide. From E-commerce to Robotics, LegalTech to Media & Entertainment, our diverse range of offerings caters to a wide array of industries, bringing cutting-edge solutions to fuel growth and success.Explore our remarkable partnerships, renowned clientele, and groundbreaking products such as Elektrify, a game-changing EV charging solution that is shaping the future of sustainable transportation.Discover how Destek is paving the way for the future of IT services, enabling businesses to thrive in the digital era. Immerse yourself in our world of innovation, expertise, and transformation.Join us today and unlock the power of digital transformation with Destek Pro!";

  @override
  void initState() {
    super.initState();
    print(widget.videData);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        videoId = widget.videData!.VideoId ?? "";
        _ytbPlayerController = YoutubePlayerController(
          // initialVideoId: "xcJtL7QggTI",
          initialVideoId: videoId.toString(),
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
            controlsVisibleAtStart: true,
          ),
        )..addListener(listener);
      });
    });
  }

  void listener() {
    setState(() {
      _fullScreen = _ytbPlayerController!.value.isFullScreen;
    });
  }

  void dispose(){
    super.dispose();
    _ytbPlayerController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
        return true;
      },
      child: Scaffold(
        appBar: _fullScreen
            ? null
            : AppBar(
                backgroundColor: ThemeColors.whiteColor,
                surfaceTintColor: ThemeColors.whiteColor,
                leading: IconButton(
                  splashRadius: 20,
                  onPressed: () async {
                    // Get.back();
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
                title: Text(
                  'Video Screen'.tr,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                      ),
                ),
                centerTitle: false,
                elevation: 4.0,
                bottomOpacity: 0.0,
              ),
        body: _ytbPlayerController != null
            ? _fullScreen ?
        YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _ytbPlayerController!,
            showVideoProgressIndicator: true,
          ),
          builder: (context, player) {
            return player;
          },
        ):ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      controller: _ytbPlayerController!,
                      showVideoProgressIndicator: true,
                    ),
                    builder: (context, player) {
                      return player;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          Images.logo,
                          height: 35,
                          // color: ThemeColors.primaryColor,
                        ),
                        InkWell(
                          onTap: (){
                            // Get.find<VideoController>().shareYoutubeURL(videoId!);
                            String toLaunch = 'https://www.youtube.com/watch?v=$videoId';
                            Share.share("$toLaunch");
                          },
                          child: SvgPicture.asset(
                            Images.share_button,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _fullScreen
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.videData!.VideoName.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                  _fullScreen
                      ? Container()
                      : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.videData!.videoDesc.toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
// class _GalleryVideoScreenState extends State<GalleryVideoScreen> {
//   TargetPlatform? _platform;
//   VideoPlayerController? _videoPlayerController1;
//   VideoPlayerController? _videoPlayerController2;
//
//   YoutubePlayerController? _ytbPlayerController;
//   PageController? _pageController;
//   int activePage = 1;
//   bool _fullScreen = false;
//   String? videoId = "";
//   String? descriptionText = "Description: Welcome to the world of Destek Infosolutions Private Limited, a trailblazing IT services and products company that is revolutionizing businesses through digital transformation. With an extensive portfolio of successful projects and a talented team of over 250 experts, Destek is at the forefront of driving innovation and reshaping the way organizations harness the power of technology.Join us on an awe-inspiring journey as we unveil the exceptional story of Destek, showcasing our unwavering commitment to empowering businesses worldwide. From E-commerce to Robotics, LegalTech to Media & Entertainment, our diverse range of offerings caters to a wide array of industries, bringing cutting-edge solutions to fuel growth and success.Explore our remarkable partnerships, renowned clientele, and groundbreaking products such as Elektrify, a game-changing EV charging solution that is shaping the future of sustainable transportation.Discover how Destek is paving the way for the future of IT services, enabling businesses to thrive in the digital era. Immerse yourself in our world of innovation, expertise, and transformation.Join us today and unlock the power of digital transformation with Destek Pro!";
//
//   @override
//   void initState() {
//     super.initState();
//     print(widget.videData);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       setState(() {
//         videoId = widget.videData!.snippet!.resourceId!.videoId ?? "";
//         // _ytbPlayerController = YoutubePlayerController(
//         //   // initialVideoId: "xcJtL7QggTI",
//         //   initialVideoId: videoId.toString(),
//         //   flags: const YoutubePlayerFlags(
//         //     autoPlay: true,
//         //     mute: false,
//         //     controlsVisibleAtStart: true,
//         //   ),
//         // )..addListener(listener);
//         _ytbPlayerController = YoutubePlayerController.fromVideoId(
//           videoId: videoId.toString(),
//           autoPlay: true,
//           params: const YoutubePlayerParams(
//               showFullscreenButton: true),
//         );
//         // _ytbPlayerController!.onEnterFullscreen = () {
//         //   SystemChrome.setPreferredOrientations([
//         //     DeviceOrientation.landscapeLeft,
//         //     DeviceOrientation.landscapeRight,
//         //   ]);
//         //   _fullScreen = true;
//         // };
//         // _ytbPlayerController!.onExitFullscreen = () {
//         //   _fullScreen = false;
//         // };
//       });
//     });
//   }
//
//   void listener() {
//     setState(() {
//       // _fullScreen = _ytbPlayerController!.value.isFullScreen;
//     });
//   }
//
//   void dispose(){
//     super.dispose();
//     // _ytbPlayerController!.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         await SystemChrome.setPreferredOrientations(
//             [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
//         return true;
//       },
//       child: Scaffold(
//         appBar:
//         // _fullScreen ? null :
//         MediaQuery.of(context).orientation == Orientation.landscape
//             ? null : AppBar(
//                 backgroundColor: ThemeColors.whiteColor,
//                 leading: IconButton(
//                   splashRadius: 20,
//                   onPressed: () async {
//                     // Get.back();
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(
//                     Icons.arrow_back,
//                     color: Colors.black,
//                     size: 24,
//                   ),
//                 ),
//                 title: Text(
//                   'Video Screen',
//                   style: Theme.of(context).textTheme.headline6!.copyWith(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Montserrat',
//                       ),
//                 ),
//                 centerTitle: false,
//                 elevation: 4.0,
//                 bottomOpacity: 0.0,
//               ),
//         body: _ytbPlayerController != null
//             ? ListView(
//                 // crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   YoutubePlayerScaffold(
//                     autoFullScreen: true,
//                     controller: _ytbPlayerController!,
//                     // aspectRatio: 16 / 9,
//                     builder: (context, player) {
//                       return Column(
//                         children: [
//                           player,
//                         ],
//                       );
//                     },
//                   ),
//                   // YoutubePlayerBuilder(
//                   //   player: YoutubePlayer(
//                   //     controller: _ytbPlayerController!,
//                   //     showVideoProgressIndicator: true,
//                   //   ),
//                   //   builder: (context, player) {
//                   //     return player;
//                   //   },
//                   // ),
//                   _fullScreen
//                       ? Container()
//                       : Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             widget.videData!.snippet!.title.toString(),
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Montserrat',
//                             ),
//                           ),
//                         ),
//                   _fullScreen
//                       ? Container()
//                       : Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           widget.videData!.snippet!.description.toString(),
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.normal,
//                             fontFamily: 'Montserrat',
//                           ),
//                         ),
//                       ),
//                 ],
//               )
//             : const Center(child: CircularProgressIndicator()),
//       ),
//     );
//   }
// }
