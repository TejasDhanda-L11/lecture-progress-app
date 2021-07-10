import 'dart:async';
import 'package:lecture_progress/resources/database/DatabaseQueries/DatabaseQueries.dart';
import 'package:lecture_progress/resources/functions/global_functions/timerCompleteDialog_func.dart';
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
            // debugPrint('done with timer ------------------------');
            if (TV_isStudyingAtPresent) {
              TV_studied_last_time = true;
            } else if (TV_isTakingBreakAtPresent) {
              TV_studied_last_time = false;
            }
            TV_isStudyingAtPresent = false;
            TV_isTakingBreakAtPresent = false;
            TV_isTimerCheckerRunning = false;
            TV_isMainTimerWorking = false;
            TV_timeSpent = Duration.zero;

            if (TV_studied_last_time){
              updateTimeStudiedInDB(
                    database: gapv_dbInstance!,
                    date: dateTimeIn_dd_mm_yyyy_formatNow(),
                    studyTimeToBeAdded: TV_howLong)
                .then((value) => () async {
                      customPrint('alpha 1');
                      TV_studiedTime =
                          await getHoursStudiedFromDayLoggerDB(
                              date: dateTimeIn_dd_mm_yyyy_formatNow(),
                              database: gapv_dbInstance!);
                      customPrint('alpha 2');
                      customPrint(TV_studiedTime);

                      TV_setState_TOP_TIMER_WIDGET_func(() {});
                      customPrint('alpha 3');
                    }.call());
            }

            timerCompleteDailog();

            showTimerCompleteNotification(
                message_to_show:
                    '${durationToStringTime(duration: TV_howLong)} timer has completed');
            timer.cancel();
            TV_howLong = Duration.zero;
            TV_setState_TOP_TIMER_WIDGET_func(() {});
            if (TV_setState_c_func.toString() != 'Closure: () => Null') {
              try {
                TV_setState_c_func(() {});
              } catch (e) {
                customPrint(e,
                    object2:
                        'ERROR  ERROR  ERROR  ERROR  ERROR  ERROR  ERROR  ');
              }
            }
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
