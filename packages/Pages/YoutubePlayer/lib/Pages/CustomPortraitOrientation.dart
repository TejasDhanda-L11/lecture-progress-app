import 'package:chewie/chewie.dart';
import 'package:custom_done_notdone_youtube_player_button/done_not_done_button.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';





class CustomPortraitOrientation extends StatefulWidget {
  final Database dbInstance;
  final ChewieController? chewieController;
  final String titleOfVideo;
  final int idOfVideo;
  Widget loadingScreen;
  Function Changer_gapv_isVideoDone;
  StatefulWidget TimerStatusOnTopOfPage;
  // Widget Done_Not_DoneButton_YoutubePlayer;
  CustomPortraitOrientation(
      {required this.idOfVideo,
      required this.chewieController,
      required this.titleOfVideo,
      required this.dbInstance,
      // required this.Done_Not_DoneButton_YoutubePlayer,
      required this.loadingScreen,
      required this.Changer_gapv_isVideoDone, 
      required this.TimerStatusOnTopOfPage,
      });
  @override
  _CustomPortraitOrientationState createState() =>
      _CustomPortraitOrientationState();
}

class _CustomPortraitOrientationState extends State<CustomPortraitOrientation> {

  bool showVideo = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              alignment: Alignment(1, 0),
              height: ((MediaQuery.of(context).size.width) *
                  (widget.chewieController == null? 1/(16 / 9) : 1 / widget.chewieController!.aspectRatio!)),
              child: FutureBuilder(
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
                  if  (widget.chewieController == null){
                    return widget.loadingScreen;
                  }
                  else {
                    return Chewie(
                      controller: widget.chewieController!,
                    );
                  }
                },
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

            Done_Not_DoneButton_YoutubePlayer(
              idOfVideo: widget.idOfVideo,
              dbInstance: widget.dbInstance,
              loadingScreen: widget.loadingScreen,
              gapv_isVideoDone_Changer: widget.Changer_gapv_isVideoDone,
            ),
          ],
        ),
        Column(
          children: [
            Align(
              alignment: Alignment(0, 1),
              child: widget.TimerStatusOnTopOfPage,
            ),
            SizedBox(height: 33,)
          ],
        ),
      ],
    );
  }
}
