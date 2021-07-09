import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lecture_progress/resources/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/temp_variables_timer.dart';

class CustomSelectTime extends StatefulWidget {
  bool isMainTimerWorking;
  Duration howLong;
  Duration timeSpent;
  bool isTimerCheckerRunning;
  Timer? checkerTimer;
  bool isTimerPaused;
  Function setState_func;
  CustomSelectTime(
      {required this.isMainTimerWorking,
      required this.timeSpent,
      required this.isTimerPaused,
      required this.isTimerCheckerRunning,
      required this.howLong,
      required this.checkerTimer,
      required this.setState_func});
  @override
  _CustomSelectTimeState createState() => _CustomSelectTimeState();
}

class _CustomSelectTimeState extends State<CustomSelectTime> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: Colors.white,
      ),
      width: double.infinity,
      child: Column(
        children: [
          Visibility(
            visible: !widget.isMainTimerWorking,
            child: Container(
              width: double.infinity,
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hms,
                onTimerDurationChanged: (time) {
                  howLong = time;
                  howLong = time;
                  timeSpent = Duration.zero;
                  debugPrint(
                      'howLong_Cupertino = ${widget.howLong} ---------------------------------');
                  // customPrint('setted state');
                  widget.setState_func(() {});
                },
                initialTimerDuration: Duration.zero,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Row(
            children: [
              //Reset
              Visibility(
                visible: widget.isMainTimerWorking | widget.isTimerPaused,
                child: FlatButton.icon(
                    onPressed: () {
                      isMainTimerWorking = false;
                      if (widget.checkerTimer!.isActive) {
                        widget.checkerTimer!.cancel();
                      }
                      isTimerCheckerRunning = false;
                      timeSpent = Duration.zero;
                      howLong = Duration.zero;

                      widget.setState_func(() {});
                    },
                    icon: Icon(Icons.restore),
                    label: Text('Reset')),
              ),
              //Start
              Visibility(
                visible: !widget.isMainTimerWorking | widget.isTimerPaused,
                child: FlatButton.icon(
                    onPressed: () {
                      // customPrint('Start Button Working');
                      if (!widget.isMainTimerWorking) {
                        isMainTimerWorking = true;
                      } else if (widget.isTimerPaused) {
                        isTimerPaused = false;
                        // customPrint('made widget.isTimerPaused false');
                      }
                      widget.setState_func(() {});
                    },
                    icon: Icon(Icons.double_arrow_rounded),
                    label: Text('Start')),
              ),
              // Pause
              Visibility(
                visible: widget.isMainTimerWorking && !widget.isTimerPaused,
                child: FlatButton.icon(
                    onPressed: () {
                      // isMainTimerWorking = false;
                      if (widget.checkerTimer!.isActive) {
                        widget.checkerTimer!.cancel();
                      }
                      isTimerCheckerRunning = false;
                      isTimerPaused = true;
                      widget.setState_func(() {});
                    },
                    icon: Icon(Icons.pause_rounded),
                    label: Text('Pause')),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          SizedBox(
            height: 20,
          )

          // AnimatedContainer(
          //   duration: Duration(milliseconds: 400),

          //   ),
        ],
      ),
    );
  }
}
