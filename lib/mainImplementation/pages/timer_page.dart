import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';
import 'package:lecture_progress/mainImplementation/NavigatorFunctions/navigationFunction.dart';
import 'package:lecture_progress/resources/functions/timerRelated/timerFunctions.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/temp_variables_timer.dart';
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
    if (!TV_isLastPageStillActive) {
      STATE_timerClockRunningPage = setState;
    }
    TV_isLastPageStillActive = true;
  }

  @override
  void dispose() {
    gapv_presentlyTopContext =
        gapv_presentlyLast_Top_Before_opening_Timer_Context;
    STATE_timerClockRunningPage = () => null;
    // customPrint('disposed the setState_func');
    TV_isLastPageStillActive = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    gapv_presentlyTopContext = context;

    if (TV_isMainTimerWorking &&
        !TV_isTimerCheckerRunning &&
        !TV_isTimerPaused) {
      onTimerStart();
    }

    return GestureDetector(
      onHorizontalDragEnd: (details) {
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
