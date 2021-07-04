import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lecture_progress/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/routes/routes.dart';
import 'package:lecture_progress/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/widgets/youtubePlayerWidgets/done_not_done_button.dart';
import 'package:sqflite/sqflite.dart';
import 'package:video_player/video_player.dart';

class CustomYoutubePlayer extends StatefulWidget {
  final Database dbInstance;
  final Map<String, dynamic> dataReq_youtubePlayer;
  CustomYoutubePlayer(
      {required this.dataReq_youtubePlayer, required this.dbInstance});
  @override
  _CustomYoutubePlayerState createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {
  bool chewieController_initialised = false;
  late ChewieController chewieController;
  bool isOrientationCheckerRunning = false;
  late VideoPlayerController videoPlayerController;
  late Orientation orientation;

  void chewieConfigStuff() async {
    final videoPlayerController = VideoPlayerController.network(
        widget.dataReq_youtubePlayer['video_url']);
    await videoPlayerController.initialize();

    chewieController = ChewieController(
        autoInitialize: false,
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: true,
        // allowedScreenSleep: false,
        allowFullScreen: true,
        deviceOrientationsOnEnterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ],
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ],
        aspectRatio: 16 / 9);

    setState(() {
      // debugPrint(
      //     '444444444444444444444444444444444444444444444444444444444444');
      chewieController_initialised = true;
    });
  }

  @override
  void initState() {
    super.initState();
    orientation = Orientation.landscape;
    chewieConfigStuff();
  }

  @override
  void dispose() {
    super.dispose();

    try {
      // chewieController.pause();
      Future.delayed(Duration.zero, () {
        // print('----------------------doing1');
        // videoPlayerController?.dispose();
        // print('----------------------doing2');
        // videoPlayerController.removeListener(() { });
        chewieController.videoPlayerController.removeListener(() {});
        chewieController.videoPlayerController.dispose();
        chewieController.removeListener(() {});
        chewieController.dispose();
        // print('----------------------done3');
      });
    } catch (e) {
      debugPrint('Error1------------------------------------------- $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    debugPrint('stateSet Started');

    SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(
      onWillPop: () {
        Navigator.popAndPushNamed(
            context, RouteManager.allVideosSpecificChapterPage);
        return Future.value(true);
      },
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          // velocity = details.velocity;
          customPrint(details.velocity, object2: 'homepage');
          if (details.velocity.pixelsPerSecond.dx > 1000) {
            // if (checkerTimer == null){
            if (true) {
              Navigator.pushNamed(context, RouteManager.timerPage);
            }
          }
        },
        child: Scaffold(
            // floatingActionButton: FloatingActionButton(onPressed: (){
            //   debugPrint('clicked present state ${chewieController.isFullScreen}');
            // }),
            body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (chewieController_initialised == false)
              return CircularProgressIndicator();
            else {
              debugPrint(
                  'final orientation ======================= ${orientation}');
              if (orientation == Orientation.portrait) {
                debugPrint(
                    '00000000000000000000000000000000000000000000000000000000 ${chewieController.isFullScreen}');
                Future.delayed(Duration.zero, () {
                  if (chewieController.isFullScreen) {
                    debugPrint(
                        'full screnn removeddddddddddddddddddddddddddddddddd');
                    Navigator.pop(context);
                  }
                });
                // gapv_isVideoDone = widget.dataReq_youtubePlayer['lectureCompleted'] == 'T'
                //           ? true
                //           : false;
                return CustomPortraitOrientation(
                  idOfVideo: widget.dataReq_youtubePlayer["id"],
                  dbInstance: widget.dbInstance,
                  chewieController: chewieController,
                  titleOfVideo: widget.dataReq_youtubePlayer['video_title'],
                  
                );
              } else {
                debugPrint(
                    '1111111111111111111111111111111111111111111111111111111111 ${chewieController.isFullScreen}');
                Future.delayed(Duration.zero, () {
                  if (!chewieController.isFullScreen) {
                    debugPrint(
                        'full screnn removeddddddddddddddddddddddddddddddddd');
                    chewieController.enterFullScreen();
                  }
                });

                return CustomLandscapeOrientation(
                  chewieController: chewieController,
                );
              }
            }
          },
        )),
      ),
    );
  }
}

class CustomPortraitOrientation extends StatefulWidget {
  final Database dbInstance;
  final ChewieController chewieController;
  final String titleOfVideo;
  final int idOfVideo;
  CustomPortraitOrientation(
      {
      required this.idOfVideo,
      required this.chewieController,
      required this.titleOfVideo,
      required this.dbInstance});
  @override
  _CustomPortraitOrientationState createState() =>
      _CustomPortraitOrientationState();
}

class _CustomPortraitOrientationState extends State<CustomPortraitOrientation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment(1, 0),
          height: ((MediaQuery.of(context).size.width) *
              (1 / widget.chewieController.aspectRatio!)),
          child: Visibility(
            visible: true,
            child: Chewie(
              controller: widget.chewieController,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.black12,
              // offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 3.0,
              spreadRadius: 2,
            ),
          ]),
          width: double.infinity,
          padding: EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
          child: Text(
            widget.titleOfVideo,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.w700, letterSpacing: 2.5),
          ),
        ),
        // Card(
        //   elevation: 7,
        //   child: Container(
        //     width: 500,
        //     child: Text(
        //       widget.titleOfVideo,
        //       textAlign: TextAlign.center,
        //       style: TextStyle(fontSize: 20),
        //     ),
        //   ),
        // ),
        Done_Not_DoneButton_YoutubePlayer(
          idOfVideo: widget.idOfVideo,
          
        ),
        ],
    );
  }
}

class CustomLandscapeOrientation extends StatefulWidget {
  final ChewieController chewieController;
  CustomLandscapeOrientation({required this.chewieController});
  @override
  _CustomLandscapeOrientationState createState() =>
      _CustomLandscapeOrientationState();
}

class _CustomLandscapeOrientationState
    extends State<CustomLandscapeOrientation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chewie(
        controller: widget.chewieController,
      ),
    );
  }
}
