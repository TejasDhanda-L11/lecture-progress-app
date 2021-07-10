import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';
import 'package:lecture_progress/resources/onPressed/SubjectsPage/AddSubject_onPressed.dart';
import 'package:sqflite/sqflite.dart';

class AddSubjectSubjectsPage_Widget extends StatefulWidget {
  Database database;
  AddSubjectSubjectsPage_Widget({required this.database});

  @override
  _AddSubjectSubjectsPage_WidgetState createState() =>
      _AddSubjectSubjectsPage_WidgetState();
}

class _AddSubjectSubjectsPage_WidgetState
    extends State<AddSubjectSubjectsPage_Widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              color: Colors.grey[50],
              height: 150,
              onPressed:  (){
                onPressedADDSubject(context: context, database: widget.database);
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
    );
  }
}
