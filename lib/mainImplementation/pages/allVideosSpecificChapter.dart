import 'package:flutter/material.dart';
import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';
import 'package:lecture_progress/mainImplementation/NavigatorFunctions/navigationFunction.dart';
import 'package:lecture_progress/resources/functions/allSpecificChapterVideos_funcs.dart';
import 'package:lecture_progress/resources/http_stuff/awsApiToDB.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/allVideoSpecificChapterVariables.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/resources/widgets/allSpecificChapterVideos_widgets/allSpecificChapterVideos_singlList_widget.dart';
import 'package:lecture_progress/resources/widgets/global_widgets/timer_running_top_of_page_widget.dart';
import 'package:sqflite/sqflite.dart';

class AllVideoSpecificChapter extends StatefulWidget {
  final Database dbInstance;

  final int subject_id;
  final int chapter_id;
  AllVideoSpecificChapter(
      {required this.dbInstance,
      required this.subject_id,
      required this.chapter_id});

  @override
  _AllVideoSpecificChapterState createState() =>
      _AllVideoSpecificChapterState();
}

class _AllVideoSpecificChapterState extends State<AllVideoSpecificChapter> {
  late List<Map<String, dynamic>> dataRequired_everyLectureVid;
  late List<Map<String, dynamic>> dataRequired_chapter;
  bool gotDataFromDB = false;
  Future<void> gettingImportantDataFromDB() async {
    // debugPrint('getting started --------------------------------');
    dataRequired_everyLectureVid = await widget.dbInstance.rawQuery('''
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
    // debugPrint('done --------------------------------');
    gotDataFromDB = true;
    setState(() {});
  }

  @override
  void initState() {
    STATE_AllChapterSpecificVideos = setState;
    super.initState();
    gettingImportantDataFromDB();
  }

  @override
  Widget build(BuildContext context) {
    gapv_presentlyTopContext = context;
    return WillPopScope(
      onWillPop: () {
        NAVIGATION_onBackButtonAllChapterSpecificVideos();
        return Future.value(true);
      },
      child: SafeArea(
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            // velocity = details.velocity;
            // customPrint(details.velocity,
            //     object2: 'all video specific chapter');
            if (details.velocity.pixelsPerSecond.dx > 1000) {
              // if (checkerTimer == null){
              if (true) {
                gapv_presentlyLast_Top_Before_opening_Timer_Context = context;

                NAVIGATION_openTimerPageOnTheTopOfTheStack();
              }
            }
          },
          child: FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (gotDataFromDB) {
              return AVSCV_isScreenLoadingNewPlaylistLink
                  ? Scaffold(
                      body: gapv_loadingScreen,
                    )
                  : Scaffold(
                      floatingActionButton: FloatingActionButton(
                        onPressed: () async {
                          AVSCV_isScreenLoadingNewPlaylistLink = true;
                          setState(() {});
                          await AWSApiToDB(
                                  playlistUrl: dataRequired_chapter[0]
                                      ["playlist_url"] as String)
                              .AWSApiUpdateDB_func(
                                  dbInstance: widget.dbInstance,
                                  subject_id: widget.subject_id,
                                  chapter_id: widget.chapter_id);
                          AVSCV_isScreenLoadingNewPlaylistLink = false;
                          // debugPrint(
                          //     'in youtube page refresh donnnnnneeee ---------------------------');
                          setState(() {});
                        },
                        child: Icon(Icons.refresh_rounded),
                        backgroundColor: Colors.white54,
                        foregroundColor: Colors.black38,
                      ),
                      body: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TimerStatusOnTopOfPage(),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: dataRequired_everyLectureVid.map((e) {
                                    // Duration totalLength_Duration =
                                    //     Duration(seconds: e['duration']);
                                    // // customPrint(totalLength_Duration);
                                    // String splitBy = e['lengthCompleted']
                                    //         .toString()
                                    //         .contains('-')
                                    //     ? '-'
                                    //     : ':';
                                    // Duration lengthCompleted_Duration = Duration(
                                    //     hours: int.parse(e['lengthCompleted']
                                    //         .toString()
                                    //         .split(e['lengthCompleted']
                                    //                 .toString()
                                    //                 .contains('-')
                                    //             ? '-'
                                    //             : ':')[0]),
                                    //     minutes: int.parse(e['lengthCompleted']
                                    //         .toString()
                                    //         .split(
                                    //             e['lengthCompleted'].toString().contains('-')
                                    //                 ? '-'
                                    //                 : ':')[1]),
                                    //     seconds: int.parse(e['lengthCompleted'].toString().split(e['lengthCompleted'].toString().contains('-') ? '-' : ':')[2]));
                                    // // customPrint(lengthCompleted_Duration);

                                    // Duration lengthLeftToCover = Duration(
                                    //     seconds:
                                    //         (totalLength_Duration.inSeconds -
                                    //             lengthCompleted_Duration
                                    //                 .inSeconds));
                                    // // customPrint(lengthLeftToCover);
                                    Duration lengthLeftToCover = lengthLeftToCoverForLectureVideo(dataOfVideo: e);
                                    String isLectureCompleted =
                                        e["lectureCompleted"];
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
                      
                    );
            } else {
              return gapv_loadingScreen;
            }
          }),
        ),
      ),
    );
  }
}
