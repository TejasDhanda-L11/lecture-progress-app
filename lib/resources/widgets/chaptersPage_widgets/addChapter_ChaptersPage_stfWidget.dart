import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lecture_progress/resources/onPressed/ChaptersPage/addChapter_onPressedFunc.dart';
import 'package:sqflite/sqflite.dart';

class AddChapter_ChaptersPage_stfWidget extends StatefulWidget {
  Database database;
  int subject_id;
  AddChapter_ChaptersPage_stfWidget(
      {required this.database, required this.subject_id});
  @override
  _AddChapter_ChaptersPage_stfWidgetState createState() =>
      _AddChapter_ChaptersPage_stfWidgetState();
}

class _AddChapter_ChaptersPage_stfWidgetState
    extends State<AddChapter_ChaptersPage_stfWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: DottedBorder(
        dashPattern: [2, 5, 10, 20],
        color: Colors.black26,
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
              onPressed: () async {
                await onPressedAddChapter_ChaptersPage(
                    context: context,
                    database: widget.database,
                    subject_id: widget.subject_id);
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
    );
  }
}
