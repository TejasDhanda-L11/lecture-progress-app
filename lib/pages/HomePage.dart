import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lecture_progress/database/HomePageDB.dart';
import 'package:lecture_progress/routes/routes.dart';
import 'package:lecture_progress/widgets/addContainer_Widget.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LectureProgressHelper _lectureProgressHelper = LectureProgressHelper();
  bool databaseInitialised = false;
  late Database db;
  late List<Map<String, dynamic>> _finalSortedList;

  @override
  void initState() {
    _lectureProgressHelper.database.then((value) async {
      print('database__________________initialised__________________________');
      db = value;
      _finalSortedList =
          await db.rawQuery('select * from subjects order by id');
      databaseInitialised = true;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (databaseInitialised) {
              return SingleChildScrollView(
                child: Column(
                  children: _finalSortedList
                      .map<Widget>((e) => GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteManager.chaptersPage,
                                  arguments: {
                                    'subject': e['id'],
                                    'dbInstance': db
                                  });
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
                                
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.add_circle_outline_outlined,size: 40,),
                                  Text('Add Subject',style: TextStyle(fontSize: 20),)
                                ],
                              )),
                        ),
                      ),
                    )
                  ]).toList(),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
