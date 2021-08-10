import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:custom_highly_reusable_functions/HighlyReusableFunctions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:video_player/video_player.dart';

import 'Pages/CustomLandscapeOrientation.dart';
import 'Pages/CustomPortraitOrientation.dart';
import 'Functions/chewieInitialConfig_Function.dart';

class CustomYoutubePlayer_Temp extends StatefulWidget {
  // final Duration positionToSeekTo;
  final Database dbInstance;
  final Map<String, dynamic> dataReq_youtubePlayer;
  Widget loadingScreen;
  Function CHANGER_STATE_YoutubeVideoPlaying;
  Function NAVIGATION_onBackButtonYoutubeVideoPlaying;
  Function NAVIGATION_popTopContext;
  Function NAVIGATION_openTimerPageOnTheTopOfTheStack;
  Function CHANGER_gapv_presentlyTopContext;
  Function CHANGER_gapv_presentlyLast_Top_Before_opening_Timer_Context;
  Function Changer_gapv_isVideoDone;
  StatefulWidget TimerStatusOnTopOfPage;
  CustomYoutubePlayer_Temp({
    required this.dataReq_youtubePlayer,
    required this.dbInstance,
    required this.loadingScreen,
    required this.CHANGER_STATE_YoutubeVideoPlaying,
    required this.NAVIGATION_onBackButtonYoutubeVideoPlaying,
    required this.NAVIGATION_popTopContext,
    required this.NAVIGATION_openTimerPageOnTheTopOfTheStack,
    required this.CHANGER_gapv_presentlyTopContext,
    required this.CHANGER_gapv_presentlyLast_Top_Before_opening_Timer_Context,
    required this.Changer_gapv_isVideoDone,
    required this.TimerStatusOnTopOfPage,
  });
  @override
  _CustomYoutubePlayer_TempState createState() =>
      _CustomYoutubePlayer_TempState();
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
    widget.CHANGER_STATE_YoutubeVideoPlaying(setState_STATE: setState);

    () async {
      chewieController = await return_chewieController_afterConfigurations(
          positionToSeekTo: positionToSeekTo,
          video_url: widget.dataReq_youtubePlayer['video_url']);
      setState(() {
        chewieController_initialised = true;
        customPrint(
            'chewieController_initialised = $chewieController_initialised');
      });
    }.call();
  }

  @override
  void dispose() {
    super.dispose();
    if (chewieController_initialised)
    {try {
      Future.delayed(Duration.zero, () {
        chewieController!.videoPlayerController.removeListener(() {});
        chewieController!.videoPlayerController.dispose();
        chewieController!.removeListener(() {});
        chewieController!.dispose();
      });
    } catch (e) {
      debugPrint('Error1------------------------------------------- $e');
    }}
  }

  @override
  Widget build(BuildContext context) {
    widget.CHANGER_gapv_presentlyTopContext(context: context);

    orientation = MediaQuery.of(context).orientation;

    SystemChrome.setEnabledSystemUIOverlays([]);

    return WillPopScope(
      onWillPop: () async {
        customPrint('WILLLLLLLLLLLLLLLLLPOP523235');
        if (chewieController_initialised) {
          Duration? positionOfVideo_Duration =
              await chewieController!.videoPlayerController.position;

          customPrint('WILLLLLLLLLLLLLLLLLPOP2');

          String positionOfVideo_String =
              '${positionOfVideo_Duration!.inHours.toString().padLeft(2, "0")}-${positionOfVideo_Duration.inMinutes.remainder(60).toString().padLeft(2, "0")}-${positionOfVideo_Duration.inSeconds.remainder(60).toString().padLeft(2, "0")}';
          await widget.dbInstance.rawQuery('''
            UPDATE specific_videos
              SET "lengthCompleted" = '$positionOfVideo_String'
                WHERE id = ${widget.dataReq_youtubePlayer["id"]}
          ''');
        }

        widget.NAVIGATION_onBackButtonYoutubeVideoPlaying();
        return Future.value(true);
      },
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 1000) {
            if (true) {
              widget
                  .CHANGER_gapv_presentlyLast_Top_Before_opening_Timer_Context(
                      context: context);

              widget.NAVIGATION_openTimerPageOnTheTopOfTheStack();
            }
          }
        },
        child: Scaffold(body: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          // if (chewieController_initialised == false)
          //   return gapv_loadingScreen;
          // else {
          if (orientation == Orientation.portrait) {
            Future.delayed(Duration.zero, () {
              if (chewieController_initialised) {
                if (chewieController!.isFullScreen) {
                  widget.NAVIGATION_popTopContext();
                }
              }
            });
            return CustomPortraitOrientation(
              idOfVideo: widget.dataReq_youtubePlayer["id"],
              dbInstance: widget.dbInstance,
              chewieController:
                  chewieController_initialised ? chewieController : null,
              titleOfVideo: widget.dataReq_youtubePlayer['video_title'],
              loadingScreen: widget.loadingScreen,
              Changer_gapv_isVideoDone: widget.Changer_gapv_isVideoDone,
              TimerStatusOnTopOfPage: widget.TimerStatusOnTopOfPage,
            );
          } else {
            Future.delayed(Duration.zero, () {
              if (chewieController_initialised) {
                if (!chewieController!.isFullScreen) {
                  chewieController!.enterFullScreen();
                }
              }
            });

            return CustomLandscapeOrientation(
              chewieController: chewieController,
              loadingScreen: widget.loadingScreen,
            );
          }
        })),
      ),
    );
  }
}
