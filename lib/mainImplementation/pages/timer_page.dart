import 'dart:async';
import 'package:lecture_progress/resources/database/DatabaseQueries/DatabaseQueries.dart';
import 'package:lecture_progress/resources/functions/global_functions/timerCompleteDialog_func.dart';
import 'package:lecture_progress/resources/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/resources/notification_functionality/timer_notifications.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/temp_variables_timer.dart'
    as temp_t_v;
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
    if (!temp_t_v.isLastPageStillActive) {
      temp_t_v.setState_c_func = setState;
    }
    temp_t_v.isLastPageStillActive = true;
  }

  @override
  void dispose() {
    gapv_presentlyTopContext =
        gapv_presentlyLast_Top_Before_opening_Timer_Context;
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
    // customPrint('state of main timerpage was set again');
    if (temp_t_v.isMainTimerWorking &&
        !temp_t_v.isTimerCheckerRunning &&
        !temp_t_v.isTimerPaused) {
      if (!temp_t_v.isTimerCheckerRunning) {
        temp_t_v.checkerTimer = Timer.periodic(Duration(seconds: 1), (timer) {
          if (temp_t_v.howLong > temp_t_v.timeSpent) {
            temp_t_v.timeSpent += Duration(seconds: 1);
            // customPrint(
            // '${temp_t_v.timeSpent.inSeconds} // ${temp_t_v.howLong.inSeconds}');
            showOngoingTimerNotification(
                message_to_show:
                    '${durationToStringTime(duration: (temp_t_v.howLong - temp_t_v.timeSpent))} timer has completed');
            // top of the page timer

            temp_t_v.setState_TOP_TIMER_WIDGET_func(() {});

            if (temp_t_v.setState_c_func.toString() != 'Closure: () => Null') {
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
          }
          // after completion of timer
          else {
            // debugPrint('done with timer ------------------------');
            if (temp_t_v.isStudyingAtPresent) {
              temp_t_v.studied_last_time = true;
            } else if (temp_t_v.isTakingBreakAtPresent) {
              temp_t_v.studied_last_time = false;
            }
            temp_t_v.isStudyingAtPresent = false;
            temp_t_v.isTakingBreakAtPresent = false;
            temp_t_v.isTimerCheckerRunning = false;
            temp_t_v.isMainTimerWorking = false;
            temp_t_v.timeSpent = Duration.zero;

            if (temp_t_v.studied_last_time){
              updateTimeStudiedInDB(
                    database: gapv_dbInstance!,
                    date: dateTimeIn_dd_mm_yyyy_formatNow(),
                    studyTimeToBeAdded: temp_t_v.howLong)
                .then((value) => () async {
                      customPrint('alpha 1');
                      temp_t_v.TVT_studiedTime =
                          await getHoursStudiedFromDayLoggerDB(
                              date: dateTimeIn_dd_mm_yyyy_formatNow(),
                              database: gapv_dbInstance!);
                      customPrint('alpha 2');
                      customPrint(temp_t_v.TVT_studiedTime);

                      temp_t_v.setState_TOP_TIMER_WIDGET_func(() {});
                      customPrint('alpha 3');
                    }.call());
            }

            timerCompleteDailog();

            showTimerCompleteNotification(
                message_to_show:
                    '${durationToStringTime(duration: temp_t_v.howLong)} timer has completed');
            timer.cancel();
            temp_t_v.howLong = Duration.zero;
            temp_t_v.setState_TOP_TIMER_WIDGET_func(() {});
            if (temp_t_v.setState_c_func.toString() != 'Closure: () => Null') {
              try {
                temp_t_v.setState_c_func(() {});
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
                // Container(height: 100, width: 100, color: Colors.orange,),
                GestureDetector(
                  child: temp_t_v.showPomondoroPicker
                      ? PomondoroTypePicker()
                      : CustomSelectTime(
                          checkerTimer: temp_t_v.checkerTimer,
                          timeSpent: temp_t_v.timeSpent,
                          isTimerPaused: temp_t_v.isTimerPaused,
                          isTimerCheckerRunning: temp_t_v.isTimerCheckerRunning,
                          isMainTimerWorking: temp_t_v.isMainTimerWorking,
                          howLong: temp_t_v.howLong,
                          setState_func: setState,
                        ),
                )
              ],
            )),
      ),
    );
  }
}
