import 'package:flutter/material.dart';
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
  late List<Map<String,dynamic>> dataFromDB_table_chapters ;
  bool gotAllDataFromDB = false;

  void initialDataFunc()async{
    dataFromDB_table_chapters = await widget.db.rawQuery('select * from chapters where subject_id = ${widget.subject_id}');
      debugPrint('dataFromDB_table_chapters = $dataFromDB_table_chapters');
      gotAllDataFromDB = true;
      setState(() {
        
      });
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
            if (gotAllDataFromDB){
              return Scaffold(
                floatingActionButton: FloatingActionButton(onPressed: (){
                  Navigator.popAndPushNamed(
                    context, 
                    RouteManager.inputPlayUrl_page,
                    arguments: {
                      'subject_id':widget.subject_id,
                      'dbInstance': widget.db
                    }
                    );
                }),
                body: SingleChildScrollView(
                  child: Column(
                    children: dataFromDB_table_chapters
                        .map((e) => GestureDetector(
                          onTap: ()async{
                             Navigator.pushNamed(
                              context,
                              RouteManager.allVideosSpecificChapterPage,
                              arguments: {
                                'dataRequiredEL': await widget.db.rawQuery('''
                                select * from specific_videos
                                where subject_id = ${widget.subject_id}
                                and
                                chapter_id = ${e['id']}
                                ''')
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
                                  color: Colors.white,

                                ),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    // Chapter Name
                                    Positioned(
                                      top: 10,
                                      left: 10,
                                      child: Text(
                                        '${e['chapter_name']}',
                                        style: TextStyle(
                                          letterSpacing: 3,
                                            fontSize: 30,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                        ))
                        .toList(),
                  ),
                ),
              );
            }else{
              return CircularProgressIndicator();
            }
          
        },

      ),
    );
  }
}



