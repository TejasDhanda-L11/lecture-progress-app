import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';



class CustomYoutubePlayer extends StatefulWidget {
  const CustomYoutubePlayer({ Key? key }) : super(key: key);

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
	"https://r1---sn-cvh76ned.googlevideo.com/videoplayback?expire=1624355819&ei=i1_RYPfiDLXJ4-EP7tmW0AU&ip=13.127.199.142&id=o-APvbxehiG-CPpRYV-apb9zXE74lmI7w32kLo1-1ldBtK&itag=18&source=youtube&requiressl=yes&mh=aR&mm=31%2C26&mn=sn-cvh76ned%2Csn-qxaeeney&ms=au%2Conr&mv=m&mvi=1&pl=15&initcwndbps=715000&vprv=1&mime=video%2Fmp4&ns=LPzykWQ9bI_tOcWbzQFTM5kF&gir=yes&clen=6226981&ratebypass=yes&dur=235.125&lmt=1597638115129132&mt=1624333958&fvip=1&fexp=24001373%2C24007246&c=WEB&txp=5531422&n=qBrV_qDxnjBsfW1WB&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIgJmOArM5X4Of9XiikGx1Fp7cknTV5TskZFkz04mVH04YCIQDSjWHBvyZ1abhN9ITif6MKbdmWsnVSzbeO2ZduoTjS4Q%3D%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIhAKFn-ppd_pzNs_c_H39GaaKlMG2cSdZkb7rdJvLDZ_hNAiAp0FprgSL0PMUOtNNr0O0gQPy6p99mx4gWsPDhblJtPg%3D%3D"









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
              return CustomPortraitOrientation(chewieController: chewieController,);}
              
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
  CustomPortraitOrientation({required this.chewieController});
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
    return Column(
      children: [
        Container(alignment: Alignment(1, 0),
            height: ((MediaQuery.of(context).size.width)*(1/widget.chewieController.aspectRatio!)),
            child: Chewie(
              controller: widget.chewieController,

            ),
            ),
        Text('Hi', style: TextStyle(fontSize: 100),)
      ],
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




















































