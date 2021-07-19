import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class addContainer_Widget extends StatelessWidget {


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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            color: Color(0xFF444974),
            height: 100,
            onPressed: ()  {
            }, 
            child: Column(
              children: [
                Icon(Icons.add_alarm_rounded),
                Text('Add Alarm')
              ],
            )
            ),
        ),
      ),
    );
  }
}