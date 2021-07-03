import 'package:flutter/material.dart';
import 'package:lecture_progress/http_stuff/awsApiToDB.dart';
import 'package:lecture_progress/routes/routes.dart';
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
    return SafeArea(
      child: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (gotDataFromDB) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await AWSApiToDB(
                        playlistUrl:
                            dataRequired_chapter[0]["playlist_url"] as String)
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
              child: SingleChildScrollView(
                child: Column(
                  children: dataRequiredEL.map((e) {
                    String isLectureCompleted = e["lectureCompleted"];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteManager.singleVideoCustomPlayer,
                            arguments: {
                              'dataReq_youtubePlayer': e,
                              'dbInstance': widget.dbInstance
                            });
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: isLectureCompleted == 'F'
                              ? Colors.white
                              : Colors.grey[50],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: double.infinity,
                                // height: 100,
                                child: Image.network(
                                  e['thumbnail'],
                                ),
                                color: Colors.white,
                              ),
                              Text(
                                '${e['video_lecture_number']}. ${e['video_title']}',
                                style: TextStyle(
                                    letterSpacing: 3,
                                    fontSize: 20,
                                    color: isLectureCompleted == 'F'
                                        ? Colors.black
                                        : Colors.black12,
                                    fontWeight: FontWeight.w900),
                              ),
                              Divider(
                                height: 20,
                                indent: 10,
                                endIndent: 20,
                                thickness: 1,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(width: 10),
                                  Text(
                                    '${(e['duration'] / 3600).floor()}:${((e['duration'] / 60).floor() - (((e['duration'] / 3600).floor()) * 60)).toString().padLeft(2, "0")}:${((e['duration']) - ((e['duration'] / 60).floor() - (((e['duration'] / 3600).floor()) * 60)) * 60 - ((e['duration'] / 3600).floor()) * 3600).toString().padLeft(2, "0")}',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: isLectureCompleted == 'F'
                                            ? Colors.black
                                            : Colors.black12),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      }),
    );
  }
}
