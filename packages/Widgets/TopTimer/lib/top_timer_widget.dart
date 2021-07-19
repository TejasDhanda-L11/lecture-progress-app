import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:custom_highly_reusable_functions/HighlyReusableFunctions.dart';

class CustomTopTimerWidget extends StatefulWidget {
  bool TV_isStudyingAtPresent;
  bool TV_isTakingBreakAtPresent;
  Duration TV_howLong;
  Duration TV_timeSpent;
  Duration TV_studiedTime;

  CustomTopTimerWidget({
    required this.TV_isStudyingAtPresent,
    required this.TV_isTakingBreakAtPresent,
    required this.TV_howLong,
    required this.TV_timeSpent,
    required this.TV_studiedTime,
  });
  @override
  _CustomTopTimerWidgetState createState() =>
      _CustomTopTimerWidgetState();
}

class _CustomTopTimerWidgetState extends State<CustomTopTimerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // customPrint('setstate of top timer widget');
    String boxOfFocus_Break_None = 'NONE';
    if (widget.TV_isStudyingAtPresent) {
      boxOfFocus_Break_None = 'Focus';
    } else if (widget.TV_isTakingBreakAtPresent) {
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
                    duration: widget.TV_howLong - widget.TV_timeSpent),
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
                '${widget.TV_studiedTime.inMinutes}/500',
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.w800),
              ),
            ],
          )
        ],
      ),
    );
  }
}
