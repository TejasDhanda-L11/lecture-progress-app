import 'package:custom_add_button_dotted_border/AddButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';
import 'package:custom_database_lecture_progress/DatabaseQueries/DatabaseQueries.dart';
import 'package:custom_database_lecture_progress/DatabaseHelper.dart';
import 'package:lecture_progress/mainImplementation/NavigatorFunctions/navigationFunction.dart';
import 'package:custom_database_lecture_progress/functions/databaseInitialisation.dart';
import 'package:custom_highly_reusable_functions/HighlyReusableFunctions.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/temp_variables_timer.dart';
import 'package:lecture_progress/resources/onPressed/SubjectsPage/AddSubject_onPressed.dart';
import 'package:lecture_progress/resources/packageConnection/CONNECTION_timer_running_top_of_page_widget.dart';
import 'package:lecture_progress/resources/widgets/subjectPage/listView_SubjectPage_stfWidget.dart';
import 'package:sqflite/sqflite.dart';

class SubjectPage extends StatefulWidget {
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
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
        List _tempList = await databaseInitializer();
        gapv_dbInstance = _tempList[0];
        gapv_isDBInitialised = _tempList[1];
        _tempList = [];
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
            // customPrint(details.velocity,object2: 'SubjectPage');
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
                                      .map<Widget>(
                                          (e) => ListViewSubjectPageWidget(
                                                database: db,
                                                dataFromDB_singlesubject: e,
                                              ))
                                      .followedBy([
                                    AddButton(
                                        onPressed: onPressedADDSubject,
                                        text: 'Add Subject',
                                        icon: Icons.add_circle_outline_outlined,extraDataForFunction: {#database: db},)
                                    
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
