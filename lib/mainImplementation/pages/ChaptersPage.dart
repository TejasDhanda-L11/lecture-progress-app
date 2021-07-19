import 'package:custom_add_button_dotted_border/AddButton.dart';
import 'package:flutter/material.dart';
import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';
import 'package:lecture_progress/mainImplementation/NavigatorFunctions/navigationFunction.dart';
// import 'package:custom_database_lecture_progress/DatabaseQueries/DatabaseQueries.dart';
import 'package:custom_database_lecture_progress/DatabaseQueries/DatabaseQueries.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/resources/onPressed/ChaptersPage/addChapter_onPressedFunc.dart';
import 'package:lecture_progress/resources/widgets/chaptersPage_widgets/listViewChaptersPage_stfWidget.dart';
import 'package:lecture_progress/resources/packageConnection/CONNECTION_timer_running_top_of_page_widget.dart';
import 'package:sqflite/sqflite.dart';

class ChaptersPage extends StatefulWidget {
  final int subject_id;
  final Database db;

  ChaptersPage({required this.subject_id, required this.db});
  @override
  _ChaptersPageState createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {
  late List<Map<String, dynamic>> dataFromDB_table_chapters;

  @override
  void initState() {
    super.initState();
    gapv_isChaptersPageOn = true;
    STATE_ChaptersPage = setState;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    STATE_ChaptersPage = null;
  }

  @override
  Widget build(BuildContext context) {
    gapv_presentlyTopContext = context;
    return WillPopScope(
      onWillPop: () {
        gapv_isChaptersPageOn = false;
        NAVIGATION_onBackButtonChaptersPage();
        return Future.value(true);
      },
      child: SafeArea(
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            // velocity = details.velocity;
            // customPrint(details.velocity, object2: 'chapters');
            if (details.velocity.pixelsPerSecond.dx > 1000) {
              // if (checkerTimer == null){
              if (true) {
                gapv_presentlyLast_Top_Before_opening_Timer_Context = context;

                NAVIGATION_openTimerPageOnTheTopOfTheStack();
              }
            }
          },
          child: FutureBuilder(
            future: dataFromDB_specificChapter_forSpecificSubject(
                database: widget.db, subject_id: widget.subject_id),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                dataFromDB_table_chapters = snapshot.data ?? [];
                return Scaffold(
                  body: Column(
                    children: [
                      TimerStatusOnTopOfPage(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: dataFromDB_table_chapters
                                .map<Widget>((e) => ListViewChaptersPage(
                                      e: e,
                                      dbInstance: widget.db,
                                    ))
                                .followedBy([
                              // add subject sign stuff
                              AddButton(
                                icon: Icons.add_circle_outline_outlined,
                                text: 'Add Chapter',
                                onPressed: onPressedAddChapter_ChaptersPage,
                                extraDataForFunction: {#subject_id:widget.subject_id, #database: widget.db},
                              )
                            ]).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return gapv_loadingScreen;
              }
            },
          ),
        ),
      ),
    );
  }
}
// '${totalTimeLeft_Duration.inHours}:${totalTimeLeft_Duration.inMinutes.remainder(60)}:${totalTimeLeft_Duration.inSeconds.remainder(60)}'