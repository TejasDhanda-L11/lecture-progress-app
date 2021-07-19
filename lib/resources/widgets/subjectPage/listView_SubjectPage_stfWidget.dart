import 'package:flutter/material.dart';
import 'package:lecture_progress/mainImplementation/NavigatorFunctions/navigationFunction.dart';
import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';
import 'package:custom_highly_reusable_functions/HighlyReusableFunctions.dart';
import 'package:lecture_progress/resources/widgets/subjectPage/addSubject_SubjectsPage_stfWidget.dart';
import 'package:sqflite/sqflite.dart';

class ListViewSubjectPageWidget extends StatefulWidget {
  Database database;
  Map<String, dynamic> dataFromDB_singlesubject;
  ListViewSubjectPageWidget(
      {required this.dataFromDB_singlesubject, required this.database});

  @override
  _ListViewSubjectPageWidgetState createState() =>
      _ListViewSubjectPageWidgetState();
}

class _ListViewSubjectPageWidgetState extends State<ListViewSubjectPageWidget> {
  late List<Map<String, dynamic>> totalTimeLeft;
  late Duration totalTimeLeft_Duration;
  late List<Map<String, dynamic>> totalTimeTotal;
  late Duration totalTimeTotal_Duration;
  late List<Map<String, dynamic>> totalTimeDone;
  late Duration totalTimeDone_Duration;
  Future<bool>
      done_gettingDataOfTimeAndImplementingToAllTimeRelatedVariables() async {
    // customPrint('1');

    totalTimeLeft = await widget.database.rawQuery('''
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
          where (subject_id = ${widget.dataFromDB_singlesubject['id']})

        ''');
//         customPrint(widget.dataFromDB_singlesubject['id']);

// customPrint('1.5');
// customPrint(totalTimeLeft);
// customPrint(totalTimeLeft[0]['time_left'].round());
    if (totalTimeLeft[0]['time_left'] != null) {
      totalTimeLeft_Duration =
          Duration(seconds: (totalTimeLeft[0]['time_left'].round()));
      // customPrint('2');

      totalTimeTotal = await widget.database.rawQuery('''
          select (
            (
              sum(duration)
            )
            
          )
          as time_total
          from specific_videos
            where (subject_id = ${widget.dataFromDB_singlesubject['id']})

          ''');

      totalTimeTotal_Duration =
          Duration(seconds: (totalTimeTotal[0]['time_total'].round()));
      // customPrint('3');

      totalTimeDone = await widget.database.rawQuery('''
          select (
            (
              sum(substr(lengthCompleted, 1,2) )*3600 +
              sum(substr(lengthCompleted, 4,2))*60+
              sum(substr(lengthCompleted, 7,2)) 
            )
          )
          as time_done
          from specific_videos
            where (subject_id = ${widget.dataFromDB_singlesubject['id']})

          ''');

      totalTimeDone_Duration =
          Duration(seconds: (totalTimeDone[0]['time_done'].round()));
      // customPrint('return value');
    } else {
    totalTimeLeft_Duration = Duration.zero;
    totalTimeTotal_Duration= Duration.zero;
    totalTimeDone_Duration= Duration.zero;
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: done_gettingDataOfTimeAndImplementingToAllTimeRelatedVariables(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          // customPrint('4');

          return GestureDetector(
            onTap: () {
              gapv_subject_presently_id = widget.dataFromDB_singlesubject['id'];
              NAVIGATION_popAndPushToChaptersPage();
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 25),
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${widget.dataFromDB_singlesubject['subject_name']}',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                  Divider(
                    height: 25,
                    color: Colors.grey[400],
                    thickness: 1,
                    indent: 40,
                    endIndent: 40,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          // '${totalTimeLeft[0]['time_left']}'
                          'L:${totalTimeLeft_Duration.inHours}:${totalTimeLeft_Duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${totalTimeLeft_Duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        VerticalDivider(
                          width: 16,
                          color: Colors.grey[400],
                          thickness: 1,
                        ),
                        Text(
                          // '${totalTimeLeft[0]['time_left']}'
                          'D:${totalTimeDone_Duration.inHours}:${totalTimeDone_Duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${totalTimeDone_Duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        VerticalDivider(
                          width: 16,
                          color: Colors.grey[400],
                          thickness: 1,
                        ),
                        Text(
                          // '${totalTimeLeft[0]['time_left']}'
                          'T:${totalTimeTotal_Duration.inHours}:${totalTimeTotal_Duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${totalTimeTotal_Duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
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
