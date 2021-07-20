import 'package:chewie/chewie.dart';
import 'package:custom_highly_reusable_functions/HighlyReusableFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

Future<ChewieController> return_chewieController_afterConfigurations({required Duration positionToSeekTo, required String video_url}) async {
    
    late ChewieController chewieController;

    final videoPlayerController = VideoPlayerController.network(video_url);
    
    
    try {
      await videoPlayerController.initialize();
    } catch (e) {
      customPrint('eror', object2: e);
      throw ErrorSummary(e.toString());
    }
    chewieController = ChewieController(
        autoInitialize: false,
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
        allowedScreenSleep: false,
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
    chewieController.videoPlayerController.seekTo(positionToSeekTo);
    return chewieController;
  }
  