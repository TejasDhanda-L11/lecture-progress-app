import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lecture_progress/database/HomePageDB.dart';
import 'package:lecture_progress/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/routes/routes.dart';
import 'package:lecture_progress/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/temp_variables/temp_variables_timer.dart';
import 'package:lecture_progress/widgets/addContainer_Widget.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));


  LectureProgressHelper _lectureProgressHelper = LectureProgressHelper();
  late Database db;
  late List<Map<String, dynamic>> _finalSortedList;
  bool _finalSortedList_initialised = false;
  Velocity velocity = Velocity.zero;
  @override
  void initState() {
    customPrint(gapv_isDBInitialised,object2: 'gapv_isDBInitialised_in_init');
    if (!gapv_isDBInitialised)  {
      _lectureProgressHelper.database.then((value) async {
      print('database__________________initialised__________________________');
      gapv_dbInstance = value;
      db = gapv_dbInstance!;
      gapv_isDBInitialised = true;
      _finalSortedList = await db.rawQuery('select * from subjects order by id');
      _finalSortedList_initialised = true;
      setState(() {});
    });
    } else  {
      db = gapv_dbInstance!;
      () async {
       _finalSortedList = await db.rawQuery('select * from subjects order by id');
      _finalSortedList_initialised = true;
       setState(() {});
      }.call();
    }
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    customPrint(gapv_isDBInitialised,object2: 'gapv_isDBInitialised_in_build');
    customPrint(_finalSortedList_initialised,object2: '_finalSortedList_initialised_build');

    return WillPopScope(
      
      onWillPop: () {
        customPrint('not allowed to exit');
        return Future.value(false);
      },
      child: SafeArea(
        child: GestureDetector(
          
          
          onHorizontalDragEnd: (details){
              // velocity = details.velocity;
              customPrint(details.velocity,object2: 'homepage');
            if (details.velocity.pixelsPerSecond.dx > 1000){
              // if (checkerTimer == null){
              if (true){
              Navigator.pushNamed(context, RouteManager.timerPage);
    
              } 
            }
    
          },
          child: FutureBuilder(
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (gapv_isDBInitialised && _finalSortedList_initialised) {
                return Scaffold(
                  floatingActionButton: FloatingActionButton(onPressed: () {
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(content: Container(color: Colors.orange,height: 100,width: 100,), actions: []));
                  }),
                  body: SingleChildScrollView(
                    child: Column(
                      children: _finalSortedList
                          .map<Widget>((e) => GestureDetector(
                                onTap: () {
                                  gapv_subject_presently_id = e['id'];
                                  Navigator.popAndPushNamed(
                                      context, RouteManager.chaptersPage,
                                      );
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
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                    autofocus: true,
                                                    onSubmitted:
                                                        (String text) async {
                                                      await db
                                                          .rawQuery(
                                                              'INSERT INTO subjects(subject_name) VALUES ("$text")')
                                                          .then((value) =>
                                                              Navigator.pop(
                                                                  context,
                                                                  RouteManager
                                                                      .homePage));
                                                      _finalSortedList =
                                                          await db.rawQuery(
                                                              'select * from subjects order by id');
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
                                        'Add Subject',
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
        ),
      ),
    );
  }
}
