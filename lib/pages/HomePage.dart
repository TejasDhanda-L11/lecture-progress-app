import 'package:flutter/material.dart';
import 'package:lecture_progress/database/HomePageDB.dart';
import 'package:lecture_progress/routes/routes.dart';
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
      _finalSortedList = await db.rawQuery('select * from subjects order by id');
      databaseInitialised = true;
      setState(() {
        
      });
      
    });


    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () async{
          
          
        },),
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
            if (databaseInitialised){
            return SingleChildScrollView(
            child: Column(
              children: _finalSortedList
                  .map((e) => GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteManager.chaptersPage,
                            arguments: {
                              'subject' : e['id'],
                              'dbInstance': db
                            }
                            );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          margin: EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23),
                            gradient: LinearGradient(
                                colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)]),
                          ),
                          child: Align(
                            alignment: Alignment(0, -0.7),
                            child: Text(
                              '${e['subject_name']}',
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
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
