import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';



class CustomYoutubePlayer extends StatefulWidget {

  String urlToVideoServer;
  final String titleOfVideo;
  CustomYoutubePlayer(
    {
      this.urlToVideoServer = 
        	"https://r3---sn-cvh76ned.googlevideo.com/videoplayback?expire=1624376988&ei=PLLRYN6BJqCJ4t4Pn4W8wAE&ip=13.127.199.142&id=o-ALOOvI_qSl33asj2JwjWCDjjBtXb5InLBkw95YaVI9OU&itag=22&source=youtube&requiressl=yes&mh=TP&mm=31%2C26&mn=sn-cvh76ned%2Csn-qxaeen7e&ms=au%2Conr&mv=m&mvi=3&pl=15&initcwndbps=673750&vprv=1&mime=video%2Fmp4&ns=dSn0aB00t218zp286c9RNFMF&cnr=14&ratebypass=yes&dur=216.363&lmt=1574954669678757&mt=1624355325&fvip=3&fexp=24001373%2C24007246&c=WEB&txp=5535432&n=8tYw3xZiKNNFbIyMD&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRAIgRRjciXlU3smhqz8UWo73hukx5__KmTWZBd-b27URjWACIGz4ZmR8u1msWxatmIq9XT0GHJ_ApFFmVZatdyR0bZvm&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRgIhAK2WLjPAirN0tgMIs7dwCrvz4kJPfMPgkDhsuRVbAVcXAiEAoqgQLE4qayOfbgZEq3YGDe4NgfiG7l5XqgEf1dZLAXM%3D"
        ,
      this.titleOfVideo = "Worlds Collide (ft. Nicki Taylor) | Worlds 2015 - League of Legends",

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
      widget.urlToVideoServer
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
    super.dispose();
    chewieController.dispose();
    videoPlayerController.dispose();
  }









  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    debugPrint('stateSet Started');


    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
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
              return CustomPortraitOrientation(chewieController: chewieController,titleOfVideo: widget.titleOfVideo,);
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




















































