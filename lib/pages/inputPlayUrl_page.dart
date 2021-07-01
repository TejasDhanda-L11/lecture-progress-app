import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lecture_progress/http_stuff/awsApiToDB.dart';
import 'package:sqflite/sqflite.dart';
class inputPlaylistURLPage extends StatefulWidget {
  final Database dbInstance;
  final int subject_id;
  inputPlaylistURLPage({required this.dbInstance, required this.subject_id});
  @override
  _inputPlaylistURLPageState createState() => _inputPlaylistURLPageState();
}

class _inputPlaylistURLPageState extends State<inputPlaylistURLPage> {
  bool done = false;
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return 

       Scaffold(
    
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                color: Colors.black,
                padding: EdgeInsets.only(top: 10,left: 10, right: 10),
                height: 200,
                child: TextField(
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    
                  ),
                  autofocus: true,
                  decoration: InputDecoration(  
                    border: InputBorder.none,  
                    labelText: 'Playlist URL',  
                      
                  ),  
                
                  onSubmitted: (text) async {
                      print(text);
                      if (!done){
                        
                        AWSApiToDB(playlistUrl: text).AWSApiToDB_func(dbInstance: widget.dbInstance, subject_id: widget.subject_id);
                        Navigator.pop(context);
                      }
                  },
                ),
              )
            ],
          ),
        ),
        
      
    );
  }
}