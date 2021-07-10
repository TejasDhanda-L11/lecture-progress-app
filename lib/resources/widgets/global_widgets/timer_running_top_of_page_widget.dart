import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';
import 'package:lecture_progress/resources/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/temp_variables_timer.dart'
    ;
import 'package:lecture_progress/mainImplementation/temp_variables/temp_variables_timer.dart';

class TimerStatusOnTopOfPage extends StatefulWidget {
  @override
  _TimerStatusOnTopOfPageState createState() => _TimerStatusOnTopOfPageState();
}

class _TimerStatusOnTopOfPageState extends State<TimerStatusOnTopOfPage> {



  @override
  void initState() {
    super.initState();
    STATE_TopTimerWidget = setState;
    
  }

  @override
  Widget build(BuildContext context) {
    customPrint('setstate of top timer widget');
    String boxOfFocus_Break_None = 'NONE';
    if (TV_isStudyingAtPresent) {
      boxOfFocus_Break_None = 'Focus';
    } else if (TV_isTakingBreakAtPresent) {
      boxOfFocus_Break_None = 'Rest';
    }

    double fontSize = 17;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
      // height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                'Timer',
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                durationToStringTime(
                    duration: TV_howLong - TV_timeSpent),
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '[${boxOfFocus_Break_None}]',
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1),
              )
            ],
          ),
          Row(
            children: [
              Text(
                '${TV_studiedTime.inMinutes}/500',
                style: TextStyle(fontSize: fontSize,
                fontWeight: FontWeight.w800
                
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
