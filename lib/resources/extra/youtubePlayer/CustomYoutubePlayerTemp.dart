import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:custom_highly_reusable_functions/HighlyReusableFunctions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:video_player/video_player.dart';



import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';
import 'package:lecture_progress/mainImplementation/NavigatorFunctions/navigationFunction.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';



import 'Pages/CustomLandscapeOrientation.dart';
import 'Pages/CustomPortraitOrientation.dart';
import 'Functions/chewieInitialConfig_Function.dart';

class CustomYoutubePlayer_Temp extends StatefulWidget {
  // final Duration positionToSeekTo;
  final Database dbInstance;
  final Map<String, dynamic> dataReq_youtubePlayer;
  CustomYoutubePlayer_Temp({
    required this.dataReq_youtubePlayer,
    required this.dbInstance,
  });
  @override
  _CustomYoutubePlayer_TempState createState() => _CustomYoutubePlayer_TempState();
}

class _CustomYoutubePlayer_TempState extends State<CustomYoutubePlayer_Temp> {
  
  


  Duration positionToSeekTo = Duration.zero;

  bool chewieController_initialised = false;
  ChewieController? chewieController;
  bool isOrientationCheckerRunning = false;
  late VideoPlayerController videoPlayerController;
  late Orientation orientation;



  @override
  void initState() {
    positionToSeekTo = widget.dataReq_youtubePlayer['lectureCompleted'] == 'T'
        ? Duration.zero
        : stringToDurationDB(
            duration: widget.dataReq_youtubePlayer['lengthCompleted']);
    super.initState();
    orientation = Orientation.landscape;
    STATE_YoutubeVideoPlaying = setState;

    ()
    async {chewieController = await return_chewieController_afterConfigurations(positionToSeekTo: positionToSeekTo, video_url: widget.dataReq_youtubePlayer['video_url']);
      setState(() {
      chewieController_initialised = true;
    });
    }.call();
  }

  @override
  void dispose() {
    super.dispose();

    try {
      Future.delayed(Duration.zero, () {
        chewieController!.videoPlayerController.removeListener(() {});
        chewieController!.videoPlayerController.dispose();
        chewieController!.removeListener(() {});
        chewieController!.dispose();
      });
    } catch (e) {
      debugPrint('Error1------------------------------------------- $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    gapv_presentlyTopContext = context;

    orientation = MediaQuery.of(context).orientation;

    SystemChrome.setEnabledSystemUIOverlays([]);

    return WillPopScope(
      onWillPop: () async {
        Duration? positionOfVideo_Duration =
            await chewieController!.videoPlayerController.position;
        String positionOfVideo_String =
            '${positionOfVideo_Duration!.inHours.toString().padLeft(2, "0")}-${positionOfVideo_Duration.inMinutes.remainder(60).toString().padLeft(2, "0")}-${positionOfVideo_Duration.inSeconds.remainder(60).toString().padLeft(2, "0")}';
        await widget.dbInstance.rawQuery('''
            UPDATE specific_videos
              SET "lengthCompleted" = '$positionOfVideo_String'
                WHERE id = ${widget.dataReq_youtubePlayer["id"]}
          ''');
        NAVIGATION_onBackButtonYoutubeVideoPlaying();
        return Future.value(true);
      },
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 1000) {
            if (true) {
              gapv_presentlyLast_Top_Before_opening_Timer_Context = context;

              NAVIGATION_openTimerPageOnTheTopOfTheStack();
            }
          }
        },
        child: Scaffold(
            body: 
            FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            // if (chewieController_initialised == false)
            //   return gapv_loadingScreen;
            // else {
              if (orientation == Orientation.portrait) {
                Future.delayed(Duration.zero, () {
                  if (chewieController_initialised)
                  {
                    if (chewieController!.isFullScreen) {
                    NAVIGATION_popTopContext();
                  }
                  }
                });
                return CustomPortraitOrientation(
                  idOfVideo: widget.dataReq_youtubePlayer["id"],
                  dbInstance: widget.dbInstance,
                  chewieController: chewieController_initialised?chewieController : null,
                  titleOfVideo: widget.dataReq_youtubePlayer['video_title'],
                  
                );
              } 
              else {
                Future.delayed(Duration.zero, () {
                  if (chewieController_initialised)
                  {if (!chewieController!.isFullScreen) {
                    chewieController!.enterFullScreen();
                  }}
                });

                return CustomLandscapeOrientation(
                  chewieController: chewieController,
                );
              }
            }
            
          
        )
        ),
      ),
    );
  }
}

