import 'package:flutter/material.dart';
import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';
import 'package:custom_AWSApi_lecture_progress_app/awsApiToDB.dart';
import 'package:sqflite/sqflite.dart';

void onPressedAddChapter_ChaptersPage(
    {required BuildContext context,
    required Database database,
    required subject_id}) async {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      isScrollControlled: true,
      context: context,
      builder:  (BuildContext context)  {
        return Container(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100,
                child:  TextField(
                  keyboardType: TextInputType.text,
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
                    await AWSApiToDB(playlistUrl: text).AWSApiToDB_func(
                        dbInstance: database, subject_id: subject_id);
                    STATE_ChaptersPage!((){});

                        
                  },
                ),
              )
            ],
          ),
        );
      });
}
