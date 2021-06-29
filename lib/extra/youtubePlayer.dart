import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';



class CustomYoutubePlayer extends StatefulWidget {
  final Map<String,dynamic> dataReq_youtubePlayer;
  CustomYoutubePlayer(
    {
      required this.dataReq_youtubePlayer,

    }
  );
  @override
  _CustomYoutubePlayerState createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {

  bool chewieController_initialised = false;
  late ChewieController chewieController;
  bool isOrientationCheckerRunning = false;
  late VideoPlayerController videoPlayerController;
  late Orientation orientation ;

  void chewieConfigStuff () async{
    final videoPlayerController = VideoPlayerController.network(
      widget.dataReq_youtubePlayer['video_url']
    );
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      autoInitialize: false,
      videoPlayerController: videoPlayerController,
      autoPlay: true,
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
      aspectRatio: 16/9

    );

    setState(() {
      debugPrint('444444444444444444444444444444444444444444444444444444444444');
      chewieController_initialised = true;

    });

  }

  @override
  void initState()  {
    super.initState();
    orientation = Orientation.landscape;
    chewieConfigStuff();

  }

  @override
  void dispose() {
    // if (chewieController.isPlaying){
    //       try{
    //       chewieController.pause();
    //       chewieController.dispose();
    //       }
    //       catch (e){
    //         debugPrint('Errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr2 $e');
    //       }
    //     }
    super.dispose();
  }









  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    debugPrint('stateSet Started');


    SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(
      onWillPop: () {
        if (chewieController.isPlaying){
          try{
          chewieController.pause();
          // chewieController.dispose();
          // videoPlayerController.dispose();
          }
          catch (e){
            debugPrint('Errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr1 $e');
          }
        }
        return Future.value(true);
      },
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(onPressed: (){
        //   debugPrint('clicked present state ${chewieController.isFullScreen}');
        // }),
        body:
        FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (chewieController_initialised == false)  return CircularProgressIndicator();
            else {
              debugPrint('final orientation ======================= ${orientation}');
              if (orientation == Orientation.portrait) {
                debugPrint('00000000000000000000000000000000000000000000000000000000 ${chewieController.isFullScreen}');
                Future.delayed(Duration.zero,(){

                  if (chewieController.isFullScreen){
                    debugPrint('full screnn removeddddddddddddddddddddddddddddddddd');
                    Navigator.pop(context);
                    }
                    });
                return CustomPortraitOrientation(chewieController: chewieController,titleOfVideo: widget.dataReq_youtubePlayer['video_title'],);
                }

              else {
                debugPrint('1111111111111111111111111111111111111111111111111111111111 ${chewieController.isFullScreen}');
                Future.delayed(Duration.zero,(){

                  if (!chewieController.isFullScreen){
                    debugPrint('full screnn removeddddddddddddddddddddddddddddddddd');
                    chewieController.enterFullScreen();
                    }
                });

                return CustomLandscapeOrientation(chewieController: chewieController,);}
            }
          },

        )

      ),
    );
  }

}


class CustomPortraitOrientation extends StatefulWidget {
  final ChewieController chewieController;
  final String titleOfVideo;
  CustomPortraitOrientation(
    {
      required this.chewieController,
      required this.titleOfVideo
    }
  );
  @override
  _CustomPortraitOrientationState createState() => _CustomPortraitOrientationState();
}

class _CustomPortraitOrientationState extends State<CustomPortraitOrientation> {

  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(alignment: Alignment(1, 0),
        height: ((MediaQuery.of(context).size.width)*(1/widget.chewieController.aspectRatio!)),
        child: Visibility(
          visible: true,
          child: Chewie(
            controller: widget.chewieController,

          ),
        ),
        );
  }
}



class CustomLandscapeOrientation extends StatefulWidget {
  final ChewieController chewieController;
  CustomLandscapeOrientation({required this.chewieController});
  @override
  _CustomLandscapeOrientationState createState() => _CustomLandscapeOrientationState();
}

class _CustomLandscapeOrientationState extends State<CustomLandscapeOrientation> {

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




















































