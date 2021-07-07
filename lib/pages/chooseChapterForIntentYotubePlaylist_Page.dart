import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:lecture_progress/database/HomePageDB.dart';
import 'package:lecture_progress/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/http_stuff/awsApiToDB.dart';
import 'package:lecture_progress/routes/routes.dart';
import 'package:lecture_progress/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/temp_variables/intentRelated/YotubePlaylistIntentRelated.dart';
import 'package:sqflite/sqflite.dart';

class ChooseChapterForIntentYotubePlaylistPage extends StatefulWidget {
  @override
  _ChooseChapterForIntentYotubePlaylistPageState createState() =>
      _ChooseChapterForIntentYotubePlaylistPageState();
}

class _ChooseChapterForIntentYotubePlaylistPageState
    extends State<ChooseChapterForIntentYotubePlaylistPage> {
  LectureProgressHelper _lectureProgressHelper = LectureProgressHelper();
  late Database db;
  late List<Map<String, dynamic>> _listOfSubjects;
  bool _listOfSubjects_initialised = false;
  late int subjectSelected_id;
  late String subjectSelected_name;

  bool isSubjectedSelected = false;

  @override
  void initState() {
    super.initState();
    if (!gapv_isDBInitialised) {
      _lectureProgressHelper.database.then((value) async {
        print(
            'database__________________initialised__________________________');
        gapv_dbInstance = value;
        db = gapv_dbInstance!;
        gapv_isDBInitialised = true;
        _listOfSubjects =
            await db.rawQuery('select * from subjects order by id');
        _listOfSubjects_initialised = true;
        setState(() {});
      });
    } else {
      db = gapv_dbInstance!;
      () async {
        _listOfSubjects =
            await db.rawQuery('select * from subjects order by id');
        _listOfSubjects_initialised = true;
        setState(() {});
      }.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsetsDirectional.only(top: 10, start: 10, end: 10),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              YPIR_youtubePlaylistLink,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            // ListView.builder(itemBuilder: itemBuilder)
            SizedBox(
              height: 10,
            ),
            IntrinsicHeight(
              child: FutureBuilder(
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (_listOfSubjects_initialised) {
                    return SingleChildScrollView(
                      child: Column(
                        children: _listOfSubjects.map((e) {
                          return GestureDetector(
                            onTap: () {
                              customPrint(e['subject_name']);
                              subjectSelected_id = e['id'];
                              subjectSelected_name = e['subject_name'];

                              isSubjectedSelected = true;
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: Text(
                                e['subject_name'],
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w800),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                onPressed: () async {
                  if (isSubjectedSelected) {
                    Navigator.pop(context);

                    await AWSApiToDB(playlistUrl: YPIR_youtubePlaylistLink)
                        .AWSApiToDB_func(
                            dbInstance: db,
                            subject_id: subjectSelected_id);

                    if (gapv_isChaptersPageOn){
                      Navigator.popAndPushNamed(gapv_presentlyTopContext!, RouteManager.chaptersPage);
                    }
                    // dataFromDB_table_chapters = await widget.db.rawQuery(
                    //     'select * from chapters where subject_id = ${widget.subject_id}');

                  } else {
                    customPrint('Subject Not Selected');
                  }
                },
                child: Text(
                  isSubjectedSelected
                      ? 'Should We ADD this Playlist to [${subjectSelected_name.toUpperCase()}]'
                      : 'Please Choose A Subject',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ))
          ],
        ),
      ),
    );
  }
}


// await AWSApiToDB(
//                                                                     playlistUrl:
//                                                                         text)
//                                                                 .AWSApiToDB_func(
//                                                                     dbInstance:
//                                                                         widget
//                                                                             .db,
//                                                                     subject_id:
//                                                                         widget
//                                                                             .subject_id);

//                                                             dataFromDB_table_chapters =
//                                                                 await widget.db
//                                                                     .rawQuery(
//                                                                         'select * from chapters where subject_id = ${widget.subject_id}');

//                                                             setState(() {});