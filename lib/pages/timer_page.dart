import 'dart:async';

import 'package:flutter/services.dart';
import 'package:lecture_progress/functions/global_functions/timerCompleteDialog_func.dart';
import 'package:lecture_progress/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/notification_functionality/timer_notifications.dart';
import 'package:lecture_progress/routes/routes.dart';
import 'package:lecture_progress/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/temp_variables/temp_variables_timer.dart'
    as temp_t_v;
import 'package:lecture_progress/widgets/timer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {

  Velocity velocity = Velocity.zero;
  @override
  void initState() {
    super.initState();
    // debugPrint('hi');
    if (!temp_t_v.isLastPageStillActive) {
      temp_t_v.setState_c_func = setState;
    }
    temp_t_v.isLastPageStillActive = true;
  }

  @override
  void dispose() {
    gapv_presentlyTopContext = gapv_presentlyLast_Top_Before_opening_Timer_Context;
    temp_t_v.setState_c_func = () => null;
    // customPrint('disposed the setState_func');
    temp_t_v.isLastPageStillActive = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    gapv_presentlyTopContext = context;
    // debugPrint('PAGE------------------------------------------------');
    // debugPrint('howLong = $howLong ---------------------------------');
    // debugPrint('timeSpent = $timeSpent ---------------------------------');

    if (temp_t_v.isMainTimerWorking && !temp_t_v.isTimerCheckerRunning && !temp_t_v.isTimerPaused) {
      if (!temp_t_v.isTimerCheckerRunning) {
        temp_t_v.checkerTimer = Timer.periodic(Duration(seconds: 1), (timer) {
          if (temp_t_v.howLong > temp_t_v.timeSpent) {
            temp_t_v.timeSpent += Duration(seconds: 1);
            // customPrint(
                // '${temp_t_v.timeSpent.inSeconds} // ${temp_t_v.howLong.inSeconds}');
            showOngoingTimerNotification(message_to_show: '${durationToStringTime(duration: (temp_t_v.howLong - temp_t_v.timeSpent))} timer has completed');
            // top of the page timer
            temp_t_v.setState_TOP_TIMER_WIDGET_func((){});

            if (temp_t_v.setState_c_func.toString() != 'Closure: () => Null' ) {
              // customPrint('not null setState_c_func');
              // customPrint('${temp_t_v.setState_c_func.toString()}');
              // I/flutter (23298): Closure: (() => void) => void from Function 'setState':.
              // Closure: () => Null

              try {
                temp_t_v.setState_c_func(() {});
              } catch (e) {
                customPrint(e,
                    object2:
                        'ERROR  ERROR  ERROR  ERROR  ERROR  ERROR  ERROR  ');
              }
            }
          } else {
            debugPrint('done with timer ------------------------');
            timerCompleteDailog();
            temp_t_v.isTimerCheckerRunning = false;
            temp_t_v.isMainTimerWorking = false;
            showTimerCompleteNotification(message_to_show: '${durationToStringTime(duration: temp_t_v.howLong)} timer has completed');
            timer.cancel();
            if (temp_t_v.setState_c_func.toString() != 'Closure: () => Null' ) {
              try {
                temp_t_v.setState_c_func((){});
              } catch (e) {
                customPrint(e,
                    object2:
                        'ERROR  ERROR  ERROR  ERROR  ERROR  ERROR  ERROR  ');
              }
            }
          }
        });
        temp_t_v.isTimerCheckerRunning = true;
      }
    }

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        // velocity = details.velocity;
        // customPrint(details.velocity, object2: 'timerpage');
        if (details.velocity.pixelsPerSecond.dx < -1000) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Container(
            color: Colors.black,
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                    child: Container(
                        child: TimerWidget(
                  howLong: temp_t_v.howLong,
                  timeSpent: temp_t_v.timeSpent,
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
                        visible: !temp_t_v.isMainTimerWorking,
                        child: Container(
                          width: double.infinity,
                          child: CupertinoTimerPicker(
                            mode: CupertinoTimerPickerMode.hms,
                            onTimerDurationChanged: (time) {
                              temp_t_v.howLong = time;
                              temp_t_v.timeSpent = Duration.zero;
                              // debugPrint(
                              //     'howLong_Cupertino = $howLong ---------------------------------');
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
                            visible: temp_t_v.isMainTimerWorking | temp_t_v.isTimerPaused,
                            child: FlatButton.icon(
                                onPressed: () {
                                  temp_t_v.isMainTimerWorking = false;
                                  if (temp_t_v.checkerTimer!.isActive) {
                                    temp_t_v.checkerTimer!.cancel();
                                  }
                                  temp_t_v.isTimerCheckerRunning = false;
                                  temp_t_v.timeSpent = Duration.zero;
                                  temp_t_v.howLong = Duration.zero;

                                  setState(() {});
                                },
                                icon: Icon(Icons.restore),
                                label: Text('Reset')),
                          ),
                          //Start
                          Visibility(
                            visible: !temp_t_v.isMainTimerWorking | temp_t_v.isTimerPaused,
                            child: FlatButton.icon(
                                onPressed: () {
                                  if (!temp_t_v.isMainTimerWorking) {
                                    temp_t_v.isMainTimerWorking = true;
                                  } else if (temp_t_v.isTimerPaused) {
                                    temp_t_v.isTimerPaused = false;
                                    // customPrint('made temp_t_v.isTimerPaused false');
                                  }
                                  setState(() {});
                                },
                                icon: Icon(Icons.double_arrow_rounded),
                                label: Text('Start')),
                          ),
                          // Pause
                          Visibility(
                            visible: temp_t_v.isMainTimerWorking && !temp_t_v.isTimerPaused,
                            child: FlatButton.icon(
                                onPressed: () {
                                  // temp_t_v.isMainTimerWorking = false;
                                  if (temp_t_v.checkerTimer!.isActive) {
                                    temp_t_v.checkerTimer!.cancel();
                                  }
                                  temp_t_v.isTimerCheckerRunning = false;
                                  temp_t_v.isTimerPaused = true;
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
      ),
    );
  }
}
