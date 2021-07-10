import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lecture_progress/mainImplementation/NavigatorFunctions/navigationFunction.dart';
import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/resources/widgets/subjectPage/addSubject_SubjectsPage_stfWidget.dart';
import 'package:sqflite/sqflite.dart';

class ListViewSubjectPageWidget extends StatefulWidget {
  Database database;
  ListViewSubjectPageWidget({required this.database});
  @override
  _ListViewSubjectPageWidgetState createState() =>
      _ListViewSubjectPageWidgetState();
}

class _ListViewSubjectPageWidgetState extends State<ListViewSubjectPageWidget> {
  @override
  void initState() {
    super.initState();
    STATE_ListViewSubjectPageWidget = setState;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.database.rawQuery('select * from subjects order by id'),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          List<Map<String, dynamic>> dataFromDB_subjects = snapshot.data!;
          return Column(
            children: dataFromDB_subjects
                .map<Widget>((e) => GestureDetector(
                      onTap: () {
                        gapv_subject_presently_id = e['id'];
                        NAVIGATION_popAndPushToChaptersPage();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: Colors.grey[50],
                        ),
                        child: Align(
                          alignment: Alignment(0, -0.7),
                          child: Text(
                            '${e['subject_name']}',
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ))
                .followedBy([
              AddSubjectSubjectsPage_Widget(
                database: widget.database,
              )
              // add subject sign stuff
            ]).toList(),
          );
        } else {
          return gapv_loadingScreen;
        }
      },
    );
  }
}
