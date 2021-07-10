import 'dart:async';
import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';
import 'package:lecture_progress/resources/functions/NavigatorFunctions/navigationFunction.dart';
import 'package:lecture_progress/resources/functions/timerRelated/timerFunctions.dart';
import 'package:lecture_progress/resources/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/resources/notification_functionality/timer_notifications.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/temp_variables_timer.dart'
    ;
import 'package:lecture_progress/resources/widgets/timerPage_widgets/choose_pomondoro_ways_class.dart';
import 'package:lecture_progress/resources/widgets/timerPage_widgets/custom_select_time_widget.dart';
import 'package:lecture_progress/resources/widgets/timerPage_widgets/timer_widget.dart';
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
    STATE_timerClockRunningPage = setState;
    // debugPrint('hi');
    if (!TV_isLastPageStillActive) {
      TV_setState_c_func = setState;
    }
    TV_isLastPageStillActive = true;
  }

  @override
  void dispose() {
    gapv_presentlyTopContext =
        gapv_presentlyLast_Top_Before_opening_Timer_Context;
    TV_setState_c_func = () => null;
    // customPrint('disposed the setState_func');
    TV_isLastPageStillActive = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    gapv_presentlyTopContext = context;
    // debugPrint('PAGE------------------------------------------------');
    // debugPrint('howLong = $howLong ---------------------------------');
    // debugPrint('timeSpent = $timeSpent ---------------------------------');
    // customPrint('state of main timerpage was set again');
    if (TV_isMainTimerWorking &&
        !TV_isTimerCheckerRunning &&
        !TV_isTimerPaused) {
      if (!TV_isTimerCheckerRunning) {
        TV_checkerTimer = Timer.periodic(Duration(seconds: 1), (timer) {
          TV_timerInstance = timer;
          if (TV_howLong > TV_timeSpent) {
            TV_timeSpent += Duration(seconds: 1);
            // customPrint(
            // '${TV_timeSpent.inSeconds} // ${TV_howLong.inSeconds}');
            showOngoingTimerNotification(
                message_to_show:
                    '${durationToStringTime(duration: (TV_howLong - TV_timeSpent))} timer has completed');
            // top of the page timer

            TV_setState_TOP_TIMER_WIDGET_func(() {});

            if (TV_setState_c_func.toString() != 'Closure: () => Null') {
              // customPrint('not null setState_c_func');
              // customPrint('${TV_setState_c_func.toString()}');
              // I/flutter (23298): Closure: (() => void) => void from Function 'setState':.
              // Closure: () => Null

              try {
                TV_setState_c_func(() {});
              } catch (e) {
                customPrint(e,
                    object2:
                        'ERROR  ERROR  ERROR  ERROR  ERROR  ERROR  ERROR  ');
              }
            }
          }
          // after completion of timer
          else {
            onTimerComplete();
            }
        });
        TV_isTimerCheckerRunning = true;
      }
    }

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        // velocity = details.velocity;
        // customPrint(details.velocity, object2: 'timerpage');
        if (details.velocity.pixelsPerSecond.dx < -1000) {
          NAVIGATION_popTopContext();
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
                  howLong: TV_howLong,
                  timeSpent: TV_timeSpent,
                ))),
                // Container(height: 100, width: 100, color: Colors.orange,),
                GestureDetector(
                  child: TV_showPomondoroPicker
                      ? PomondoroTypePicker()
                      : CustomSelectTime(
                          checkerTimer: TV_checkerTimer,
                          timeSpent: TV_timeSpent,
                          isTimerPaused: TV_isTimerPaused,
                          isTimerCheckerRunning: TV_isTimerCheckerRunning,
                          isMainTimerWorking: TV_isMainTimerWorking,
                          howLong: TV_howLong,
                          setState_func: setState,
                        ),
                )
              ],
            )),
      ),
    );
  }
}
