import 'package:flutter/material.dart';
import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';
import 'package:sqflite/sqflite.dart';

void onPressedADDSubject(
    {required BuildContext context, required Database database}) {
  showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100,
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  autofocus: true,
                  onSubmitted: (String text) async {
                    Navigator.pop(
                      context,
                    );
                    await database.rawQuery(
                        'INSERT INTO subjects(subject_name) VALUES ("$text")');

                    STATE_ListViewSubjectPageWidget!(() {});
                  },
                ),
              )
            ],
          ),
        );
      });
}
