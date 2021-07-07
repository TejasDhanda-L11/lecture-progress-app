import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lecture_progress/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/http_stuff/awsApiToDB.dart';
import 'package:lecture_progress/routes/routes.dart';
import 'package:lecture_progress/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/widgets/chaptersPage_widgets/listView_widget.dart';
import 'package:lecture_progress/widgets/global_widgets/timer_running_top_of_page_widget.dart';
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
  bool gotAllDataFromDB = false;

  void initialDataFunc() async {
    dataFromDB_table_chapters = await widget.db.rawQuery(
        'select * from chapters where subject_id = ${widget.subject_id}');

    // debugPrint('dataFromDB_table_chapters = $dataFromDB_table_chapters');
    gotAllDataFromDB = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initialDataFunc();
    gapv_isChaptersPageOn = true;
  }

  @override
  Widget build(BuildContext context) {
    gapv_presentlyTopContext = context;
    return WillPopScope(
      onWillPop: () {
        gapv_isChaptersPageOn = false;
        Navigator.popAndPushNamed(context, RouteManager.homePage);
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

                Navigator.pushNamed(context, RouteManager.timerPage);
              }
            }
          },
          child: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (gotAllDataFromDB) {
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
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: DottedBorder(
                                  dashPattern: [2, 5, 10, 20],
                                  color: Color(0xFFEAECFF),
                                  strokeWidth: 2,
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(10),
                                  child: Container(
                                    width: double.infinity,
                                    child: FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        color: Colors.grey[50],
                                        height: 150,
                                        onPressed: () {
                                          showModalBottomSheet<void>(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              10))),
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  padding:
                                                      MediaQuery.of(context)
                                                          .viewInsets,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        height: 100,
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          maxLines: null,
                                                          style: TextStyle(
                                                            fontSize: 23,
                                                            color: Colors.black,
                                                          ),
                                                          autofocus: true,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                          onSubmitted:
                                                              (text) async {
                                                            // print(text);

                                                            Navigator.pop(
                                                                context);
                                                            await AWSApiToDB(
                                                                    playlistUrl:
                                                                        text)
                                                                .AWSApiToDB_func(
                                                                    dbInstance:
                                                                        widget
                                                                            .db,
                                                                    subject_id:
                                                                        widget
                                                                            .subject_id);

                                                            dataFromDB_table_chapters =
                                                                await widget.db
                                                                    .rawQuery(
                                                                        'select * from chapters where subject_id = ${widget.subject_id}');

                                                            setState(() {});
                                                            
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.add_circle_outline_outlined,
                                              size: 40,
                                            ),
                                            Text(
                                              'Add Chapter',
                                              style: TextStyle(fontSize: 20),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
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