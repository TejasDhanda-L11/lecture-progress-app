import 'package:flutter/material.dart';
import 'package:lecture_progress/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/temp_variables/global_all_page_variable.dart';
import 'package:sqflite/sqflite.dart';

class Done_Not_DoneButton_YoutubePlayer extends StatefulWidget {
  Database dbInstance = gapv_dbInstance!;
  int idOfVideo;
  Done_Not_DoneButton_YoutubePlayer({required this.idOfVideo});

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
          bool isVideoDone = snapshot.data![0]['lectureCompleted']  == 'T'
                          ? true
                          : false;
          gapv_isVideoDone = isVideoDone;
          String? T_F_toBeSetOnClick;
          if (isVideoDone) {
            T_F_toBeSetOnClick = 'F';
          } else {
            T_F_toBeSetOnClick = 'T';
          }
          // customPrint(T_F_toBeSetOnClick);
          return FlatButton.icon(
              onPressed: () async {
                // print(
                //     'id ---------------------------------------- ${widget.idOfVideo}');
                widget.dbInstance.rawQuery('''
                    UPDATE specific_videos
                    SET lectureCompleted = '${T_F_toBeSetOnClick}'
                    WHERE id = ${widget.idOfVideo}
                    ''');
                setState(() {});
              },
              icon: isVideoDone == false
                  ? Icon(Icons.done_outline_rounded)
                  : Icon(Icons.close_outlined),
              label: isVideoDone == false ? Text('Done') : Text('Not Done'));
        } else {
          return gapv_loadingScreen;
        }
      },
    );
  }
}
