import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'onPressed___done_not_done.dart';

class Done_Not_DoneButton_YoutubePlayer extends StatefulWidget {
  // Database dbInstance = gapv_dbInstance!;
  Database dbInstance;
  int idOfVideo;
  Widget loadingScreen;
  Function gapv_isVideoDone_Changer;
  Done_Not_DoneButton_YoutubePlayer(
      {required this.idOfVideo,
      required this.dbInstance,
      required this.loadingScreen,
      required this.gapv_isVideoDone_Changer,
      });

  @override
  _Done_Not_DoneButton_YoutubePlayerState createState() =>
      _Done_Not_DoneButton_YoutubePlayerState();
}

class _Done_Not_DoneButton_YoutubePlayerState
    extends State<Done_Not_DoneButton_YoutubePlayer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.dbInstance.rawQuery('''
          SELECT "lectureCompleted" FROM specific_videos
            WHERE id = ${widget.idOfVideo};
        '''),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          bool isVideoDone =
              snapshot.data![0]['lectureCompleted'] == 'T' ? true : false;
          widget.gapv_isVideoDone_Changer(isVideoDone: isVideoDone);
          String? T_F_toBeSetOnClick;
          if (isVideoDone) {
            T_F_toBeSetOnClick = 'F';
          } else {
            T_F_toBeSetOnClick = 'T';
          }
          // customPrint(T_F_toBeSetOnClick);
          return FlatButton.icon(
              onPressed: () {
                Done_Not_Done_onPressed(
                    database: widget.dbInstance,
                    setStateFunc: setState,
                    T_F_toBeSetOnClick: T_F_toBeSetOnClick!,
                    idOfVideo: widget.idOfVideo);
              },
              icon: isVideoDone == false
                  ? Icon(Icons.done_outline_rounded)
                  : Icon(Icons.close_outlined),
              label: isVideoDone == false ? Text('Done') : Text('Not Done'));
        } else {
          return widget.loadingScreen;
        }
      },
    );
  }
}
