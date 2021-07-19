import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';
import 'package:lecture_progress/resources/database/DatabaseQueries/DatabaseQueries.dart';
import 'package:lecture_progress/resources/database/HomePageDB.dart';
import 'package:lecture_progress/mainImplementation/NavigatorFunctions/navigationFunction.dart';
import 'package:lecture_progress/resources/database/functions/databaseInitialisation.dart';
import 'package:lecture_progress/resources/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/temp_variables_timer.dart';
import 'package:lecture_progress/resources/widgets/global_widgets/timer_running_top_of_page_widget.dart';
import 'package:lecture_progress/resources/widgets/subjectPage/addSubject_SubjectsPage_stfWidget.dart';
import 'package:lecture_progress/resources/widgets/subjectPage/listView_SubjectPage_stfWidget.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

  LectureProgressHelper _lectureProgressHelper = LectureProgressHelper();
  late Database db;
  late List<Map<String, dynamic>> _finalSortedList;
  bool topTimerWidgetInitialised_withStudiedTime = false;
  Velocity velocity = Velocity.zero;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    STATE_SubjectSelectionPage = setState;

    // customPrint(gapv_isDBInitialised,object2: 'gapv_isDBInitialised_in_init');
    () async {
      if (!gapv_isDBInitialised) {
        await databaseInitializer();
      }
    }.call().then((value) async {
      db = gapv_dbInstance!;

      TV_studiedTime = await getHoursStudiedFromDayLoggerDB(
          database: gapv_dbInstance!, date: dateTimeIn_dd_mm_yyyy_formatNow());
      topTimerWidgetInitialised_withStudiedTime = true;

      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    STATE_SubjectSelectionPage = setState;
    // customPrint('setted state');
    gapv_presentlyTopContext = context;

    return WillPopScope(
      onWillPop: () {
        STATE_SubjectSelectionPage = null;

        customPrint('not allowed to exit');
        return Future.value(false);
      },
      child: SafeArea(
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            // velocity = details.velocity;
            // customPrint(details.velocity,object2: 'homepage');
            if (details.velocity.pixelsPerSecond.dx > 1000) {
              // if (checkerTimer == null){
              if (true) {
                gapv_presentlyLast_Top_Before_opening_Timer_Context = context;
                NAVIGATION_openTimerPageOnTheTopOfTheStack();
              }
            }
          },
          child: FutureBuilder(
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (gapv_isDBInitialised &&
                  topTimerWidgetInitialised_withStudiedTime) {
                return Scaffold(
                  // floatingActionButton: FloatingActionButton(onPressed: () {
                  // customPrint(DateTime.now().toString());
                  // file_picker_simple();
                  //   // custom_showDialog(context: context);
                  //   // showCupertinoDialog(
                  //   //     context: context,
                  //   //     builder: (context) {
                  //   //       return Container(
                  //   //         height: 100,
                  //   //         width: 100,
                  //   //         color: Colors.red,
                  //   //       );
                  //   //     });
                  //   // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //   // ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(content: Container(color: Colors.orange,height: 100,width: 100,), actions: []));
                  // }),
                  body: Column(
                    children: [
                      TimerStatusOnTopOfPage(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: FutureBuilder(
                            future: db
                                .rawQuery('select * from subjects order by id'),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Map<String, dynamic>>>
                                    snapshot) {
                              if (snapshot.hasData) {
                                List<Map<String, dynamic>> dataFromDB_subjects =
                                    snapshot.data!;
                                return Column(
                                  children: dataFromDB_subjects
                                      .map<Widget>((e) => ListViewSubjectPageWidget(
                                        database: db,
                                            dataFromDB_singlesubject: e,
                                          ))
                                      .followedBy([
                                    AddSubjectSubjectsPage_Widget(
                                      database: db,
                                    )
                                    // add subject sign stuff
                                  ]).toList(),
                                );
                              } else {
                                return gapv_loadingScreen;
                              }
                            },
                          ),

                          //     child: ListViewSubjectPageWidget(
                          //   database: db,
                          // )
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
