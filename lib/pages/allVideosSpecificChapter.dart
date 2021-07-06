import 'package:flutter/material.dart';
import 'package:lecture_progress/functions/allSpecificChapterVideos_funcs.dart';
import 'package:lecture_progress/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/http_stuff/awsApiToDB.dart';
import 'package:lecture_progress/routes/routes.dart';
import 'package:lecture_progress/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/widgets/allSpecificChapterVideos_widgets/allSpecificChapterVideos_singlList_widget.dart';
import 'package:lecture_progress/widgets/global_widgets/timer_running_top_of_page_widget.dart';
import 'package:sqflite/sqflite.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class AllVideoSpecificChapter extends StatefulWidget {
  final Database dbInstance;

  int subject_id;
  int chapter_id;
  AllVideoSpecificChapter(
      {required this.dbInstance,
      required this.subject_id,
      required this.chapter_id});

  @override
  _AllVideoSpecificChapterState createState() =>
      _AllVideoSpecificChapterState();
}

class _AllVideoSpecificChapterState extends State<AllVideoSpecificChapter> {
  late List<Map<String, dynamic>> dataRequiredEL;
  late List<Map<String, dynamic>> dataRequired_chapter;

  bool gotDataFromDB = false;
  Future<void> gettingImportantDataFromDB() async {
    debugPrint('getting started --------------------------------');
    dataRequiredEL = await widget.dbInstance.rawQuery('''
                                select * from specific_videos
                                where subject_id = ${widget.subject_id}
                                and
                                chapter_id = ${widget.chapter_id}
                                ''');
    dataRequired_chapter = await widget.dbInstance.rawQuery('''
                                select * from chapters
                                where 
                                id = ${widget.chapter_id}
                                ''');
    debugPrint('done --------------------------------');
    gotDataFromDB = true;
    setState(() {});
  }

  @override
  void initState() {
    customPrint('initialised_init the allVideosSpecificPage');
    super.initState();
    // print('dataRequiredEL = ${dataRequiredEL}');
    // isLectureCompleted = dataRequiredEL[0]["lectureCompleted"] as String;
    gettingImportantDataFromDB();
  }

  void onRefreshFunc() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    gapv_presentlyTopContext = context;
    return WillPopScope(
      onWillPop: () {
        Navigator.popAndPushNamed(context, RouteManager.chaptersPage);
        return Future.value(true);
      },
      child: SafeArea(
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            // velocity = details.velocity;
            customPrint(details.velocity,
                object2: 'all video specific chapter');
            if (details.velocity.pixelsPerSecond.dx > 1000) {
              // if (checkerTimer == null){
              if (true) {
                gapv_presentlyLast_Top_Before_opening_Timer_Context = context;

                Navigator.pushNamed(context, RouteManager.timerPage);
              }
            }
          },
          child: FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (gotDataFromDB) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    await AWSApiToDB(
                            playlistUrl: dataRequired_chapter[0]["playlist_url"]
                                as String)
                        .AWSApiUpdateDB_func(
                            dbInstance: widget.dbInstance,
                            subject_id: widget.subject_id,
                            chapter_id: widget.chapter_id);
                    debugPrint(
                        'in youtube page refresh donnnnnneeee ---------------------------');
                  },
                  child: Icon(Icons.refresh_rounded),
                  backgroundColor: Colors.white54,
                  foregroundColor: Colors.black38,
                ),
                body: LiquidPullToRefresh(
                  height: 80,
                  onRefresh: () async {
                    await gettingImportantDataFromDB();
                    setState(() {});
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TimerStatusOnTopOfPage(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: dataRequiredEL.map((e) {
                              Duration totalLength_Duration =
                                  Duration(seconds: e['duration']);
                              // customPrint(totalLength_Duration);
                        
                              Duration lengthCompleted_Duration = Duration(
                                  hours: int.parse(
                                      e['lengthCompleted'].toString().split('-')[0]),
                                  minutes: int.parse(
                                      e['lengthCompleted'].toString().split('-')[1]),
                                  seconds: int.parse(
                                      e['lengthCompleted'].toString().split('-')[2]));
                              // customPrint(lengthCompleted_Duration);
                        
                              Duration lengthLeftToCover = Duration(
                                  seconds: (totalLength_Duration.inSeconds -
                                      lengthCompleted_Duration.inSeconds));
                              // customPrint(lengthLeftToCover);
                        
                              String isLectureCompleted = e["lectureCompleted"];
                              return AllSpecificChapterVideos_singleList_stfWidget(
                                e: e,
                                isLectureCompleted: isLectureCompleted,
                                lengthLeftToCover: lengthLeftToCover,
                                dbInstance: widget.dbInstance,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
        ),
      ),
    );
  }
}
