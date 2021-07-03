import 'dart:async';

import 'package:flutter/services.dart';
import 'package:lecture_progress/widgets/timer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late Timer checkerTimer;
  Duration timeSpent = Duration.zero;
  Duration howLong = Duration(seconds: 1);
  bool isMainTimerWorking = false;
  bool isTimerCheckerRunning = false;
  bool isTimerPaused = false;
  @override
  void initState() {
    super.initState();
    debugPrint('hi');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    debugPrint('PAGE------------------------------------------------');
    debugPrint('howLong = $howLong ---------------------------------');
    debugPrint('timeSpent = $timeSpent ---------------------------------');

    if (isMainTimerWorking && !isTimerCheckerRunning && !isTimerPaused) {
      isTimerCheckerRunning = true;
      checkerTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (howLong > timeSpent) {
          timeSpent += Duration(seconds: 1);
          debugPrint('${timeSpent.inSeconds} / ${howLong.inSeconds}');

          setState(() {});
        } else {
          debugPrint('done with timer ------------------------');
          isTimerCheckerRunning = false;
          isMainTimerWorking = false;
          timer.cancel();
          setState(() {});
        }
      });
    }

    return Scaffold(
      body: Container(
          color: Colors.black,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                  child: Container(
                      child: TimerWidget(
                howLong: howLong,
                timeSpent: timeSpent,
              ))),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white,
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Visibility(
                      visible: !isMainTimerWorking,
                      child: Container(
                        width: double.infinity,
                        child: CupertinoTimerPicker(
                          mode: CupertinoTimerPickerMode.hms,
                          onTimerDurationChanged: (time) {
                            howLong = time;
                            timeSpent = Duration.zero;
                            debugPrint(
                                'howLong_Cupertino = $howLong ---------------------------------');
                            setState(() {});
                          },
                          initialTimerDuration: Duration(seconds: 1),
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
                          visible: isMainTimerWorking | isTimerPaused,
                          child: FlatButton.icon(
                              onPressed: () {
                                isMainTimerWorking = false;
                                if (checkerTimer.isActive) {
                                  checkerTimer.cancel();
                                }
                                isTimerCheckerRunning = false;
                                timeSpent = Duration.zero;
                                howLong = Duration.zero;

                                setState(() {});
                              },
                              icon: Icon(Icons.restore),
                              label: Text('Reset')),
                        ),
                        //Start
                        Visibility(
                          visible: !isMainTimerWorking | isTimerPaused,
                          child: FlatButton.icon(
                              onPressed: () {
                                if (!isMainTimerWorking) {
                                  isMainTimerWorking = true;
                                } else if (isTimerPaused) {
                                  isTimerPaused = false;
                                }
                                setState(() {});
                              },
                              icon: Icon(Icons.double_arrow_rounded),
                              label: Text('Start')),
                        ),
                        // Pause
                        Visibility(
                          visible: isMainTimerWorking && !isTimerPaused,
                          child: FlatButton.icon(
                              onPressed: () {
                                // isMainTimerWorking = false;
                                if (checkerTimer.isActive) {
                                  checkerTimer.cancel();
                                }
                                isTimerCheckerRunning = false;
                                isTimerPaused = true;
                                setState(() {});
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
              )
            ],
          )),
    );
  }
}
