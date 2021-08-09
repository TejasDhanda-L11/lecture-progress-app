


import 'package:custom_list_view_all_videos_of_specific_chapter/allSpecificChapterVideos_singlList_widget.dart';
import 'package:flutter/material.dart';
import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';
import 'package:lecture_progress/mainImplementation/NavigatorFunctions/navigationFunction.dart';
import 'package:custom_AWSApi_lecture_progress_app/awsApiToDB.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/allVideoSpecificChapterVariables.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/resources/functions/allSpecificChapterVideos_funcs.dart';
import 'package:lecture_progress/resources/packageConnection/allSpecificChapterVideos_singleList_widget/CHANGER__gapv_dataReq_youtubePlayer.dart';
import 'package:lecture_progress/resources/packageConnection/CONNECTION_timer_running_top_of_page_widget.dart';
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
                                ORDER by lectureCompleted
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
                                  return AllSpecificChapterVideos_singleList_stfWidget(
                                    videoData_Map: e,
                                    NAVIGATION_popAndPushToYoutubeVideoPlaying: NAVIGATION_popAndPushToYoutubeVideoPlaying,
                                    lengthLeftToCoverForLectureVideo: lengthLeftToCoverForLectureVideo,
                                    CHANGER__gapv_dataReq_youtubePlayer: CHANGER__gapv_dataReq_youtubePlayer,
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
