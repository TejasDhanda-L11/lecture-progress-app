import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lecture_progress/http_stuff/awsApiToDB.dart';
import 'package:lecture_progress/routes/routes.dart';
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
    debugPrint('dataFromDB_table_chapters = $dataFromDB_table_chapters');
    gotAllDataFromDB = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initialDataFunc();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (gotAllDataFromDB) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: dataFromDB_table_chapters
                      .map<Widget>((e) => GestureDetector(
                            onTap: () async {
                              Navigator.pushNamed(context,
                                  RouteManager.allVideosSpecificChapterPage,
                                  arguments: {
                                    
                                    'dbInstance': widget.db,
                                    'subject_id' :widget.subject_id,
                                    'chapter_id':e['id']
                                  });
                            },
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 10, left: 10),
                                child: Text('${e['chapter_name']}',
                                    style: TextStyle(
                                        letterSpacing: 3,
                                        fontSize: 29,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900),
                                    softWrap: true),
                              ),
                            ),
                          ))
                      .followedBy([
                    // add subject sign stuff
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Colors.grey[50],
                              height: 150,
                              onPressed: () {
                                showModalBottomSheet<void>(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10))),
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 100,
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.text,
                                                maxLines: null,
                                                style: TextStyle(
                                                  fontSize: 23,
                                                  color: Colors.black,
                                                ),
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                                onSubmitted: (text) async {
                                                  // print(text);

                                                  Navigator.pop(context);
                                                  await AWSApiToDB(
                                                          playlistUrl: text)
                                                      .AWSApiToDB_func(
                                                          dbInstance: widget.db,
                                                          subject_id: widget
                                                              .subject_id);

                                                  dataFromDB_table_chapters =
                                                      await widget.db.rawQuery(
                                                          'select * from chapters where subject_id = ${widget.subject_id}');

                                                  setState(() {});
                                                  ;
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
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
