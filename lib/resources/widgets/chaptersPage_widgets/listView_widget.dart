import 'package:flutter/material.dart';
import 'package:lecture_progress/mainImplementation/NavigatorFunctions/navigationFunction.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';
import 'package:sqflite/sqflite.dart';

class ListViewChaptersPage extends StatefulWidget {
  Map<String, dynamic> e;
  Database dbInstance;
  ListViewChaptersPage({required this.e, required this.dbInstance});

  @override
  _ListViewChaptersPageState createState() => _ListViewChaptersPageState();
}

class _ListViewChaptersPageState extends State<ListViewChaptersPage> {
  late List<Map<String, dynamic>> totalTimeLeft;
  late Duration totalTimeLeft_Duration;
  late List<Map<String, dynamic>> totalTimeTotal;
  late Duration totalTimeTotal_Duration;
  late List<Map<String, dynamic>> totalTimeDone;
  late Duration totalTimeDone_Duration;
  Future<bool> done_gettingDataOfTimeAndImplementingToAllTimeRelatedVariables() async {
    totalTimeLeft = await widget.dbInstance.rawQuery('''
        select (
          (
            sum(duration)
          )
          -
          (
            sum(substr(lengthCompleted, 1,2) )*3600 +
            sum(substr(lengthCompleted, 4,2))*60+
            sum(substr(lengthCompleted, 7,2)) 
          )
        )
        as time_left
        from specific_videos
          where (subject_id = ${widget.e['subject_id']})
          and 
          (chapter_id = ${widget.e['id']})
        ''');

    totalTimeLeft_Duration =
        Duration(seconds: (totalTimeLeft[0]['time_left'].round()));

    totalTimeTotal = await widget.dbInstance.rawQuery('''
        select (
          (
            sum(duration)
          )
          
        )
        as time_total
        from specific_videos
          where (subject_id = ${widget.e['subject_id']})
          and 
          (chapter_id = ${widget.e['id']})
        ''');

    totalTimeTotal_Duration =
        Duration(seconds: (totalTimeTotal[0]['time_total'].round()));


    totalTimeDone = await widget.dbInstance.rawQuery('''
        select (
          (
            sum(substr(lengthCompleted, 1,2) )*3600 +
            sum(substr(lengthCompleted, 4,2))*60+
            sum(substr(lengthCompleted, 7,2)) 
          )
        )
        as time_done
        from specific_videos
          where (subject_id = ${widget.e['subject_id']})
          and 
          (chapter_id = ${widget.e['id']})
        ''');

    totalTimeDone_Duration =
        Duration(seconds: (totalTimeDone[0]['time_done'].round()));

    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: done_gettingDataOfTimeAndImplementingToAllTimeRelatedVariables(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            onTap: () async {
              gapv_chapter_presently_id = widget.e['id'];
              NAVIGATION_popAndPushToAllSpecificChapterVideos();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.e['chapter_name']}',
                      style: TextStyle(
                          letterSpacing: 3,
                          fontSize: 29,
                          color: Colors.black,
                          fontWeight: FontWeight.w900),
                      softWrap: true),
                  Divider(
                    height: 25,
                    color: Colors.grey[400],
                    thickness: 1,
                    indent: 40,
                    endIndent: 40,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          // '${totalTimeLeft[0]['time_left']}'
                          'L:${totalTimeLeft_Duration.inHours}:${totalTimeLeft_Duration.inMinutes.remainder(60).toString().padLeft(2,'0')}:${totalTimeLeft_Duration.inSeconds.remainder(60).toString().padLeft(2,'0')}',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        VerticalDivider(
                          width: 16,
                          color: Colors.grey[400],
                          thickness: 1,

                        ),
                        Text(
                          // '${totalTimeLeft[0]['time_left']}'
                          'D:${totalTimeDone_Duration.inHours}:${totalTimeDone_Duration.inMinutes.remainder(60).toString().padLeft(2,'0')}:${totalTimeDone_Duration.inSeconds.remainder(60).toString().padLeft(2,'0')}',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        VerticalDivider(
                          width: 16,
                          color: Colors.grey[400],
                          thickness: 1,

                        ),
                        Text(
                          // '${totalTimeLeft[0]['time_left']}'
                          'T:${totalTimeTotal_Duration.inHours}:${totalTimeTotal_Duration.inMinutes.remainder(60).toString().padLeft(2,'0')}:${totalTimeTotal_Duration.inSeconds.remainder(60).toString().padLeft(2,'0')}',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return gapv_loadingScreen;
        }
      },
    );
  }
}
