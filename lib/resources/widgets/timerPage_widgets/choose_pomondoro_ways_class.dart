import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';
import 'package:lecture_progress/resources/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/temp_variables_timer.dart'
    ;

class PomondoroTypePicker extends StatefulWidget {
  @override
  _PomondoroTypePickerState createState() => _PomondoroTypePickerState();
}

class _PomondoroTypePickerState extends State<PomondoroTypePicker> {
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
            SizedBox(height: 50),
            Visibility(
              visible: !TV_isMainTimerWorking,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      TV_howLong =
                          Duration(seconds: pomondoroList[0]['time_of_study']);
                      STATE_timerClockRunningPage!(() {});
                      TV_isStudyingAtPresent = true;
                      TV_isTakingBreakAtPresent = false;
                    },
                    onDoubleTap: () {
                      TV_howLong =
                          Duration(seconds: pomondoroList[0]['time_of_break']);
                      STATE_timerClockRunningPage!(() {});
                      TV_isStudyingAtPresent = false;
                      TV_isTakingBreakAtPresent = true;
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Text(
                            '${Duration(seconds: pomondoroList[0]['time_of_study']).inMinutes}:${Duration(seconds: pomondoroList[0]['time_of_break']).inMinutes}',
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            pomondoroList[0]['timer_name'],
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 2,
                                wordSpacing: 4),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      TV_howLong =
                          Duration(seconds: pomondoroList[1]['time_of_study']);
                      STATE_timerClockRunningPage!(() {});
                      TV_isStudyingAtPresent = true;
                      TV_isTakingBreakAtPresent = false;
                    },
                    onDoubleTap: () {
                      TV_howLong =
                          Duration(seconds: pomondoroList[1]['time_of_break']);
                      STATE_timerClockRunningPage!(() {});
                      TV_isStudyingAtPresent = false;
                      TV_isTakingBreakAtPresent = true;
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Text(
                            '${Duration(seconds: pomondoroList[1]['time_of_study']).inMinutes}:${Duration(seconds: pomondoroList[1]['time_of_break']).inMinutes}',
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            pomondoroList[1]['timer_name'],
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 2,
                                wordSpacing: 4),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                //Reset
                Visibility(
                  visible: TV_isMainTimerWorking | TV_isTimerPaused,
                  child: FlatButton.icon(
                      onPressed: () {
                        TV_isMainTimerWorking = false;
                        if (TV_checkerTimer!.isActive) {
                          TV_checkerTimer!.cancel();
                        }
                        TV_isTimerCheckerRunning = false;
                        TV_timeSpent = Duration.zero;
                        TV_howLong = Duration.zero;
                        if (TV_isStudyingAtPresent){
                          TV_studied_last_time = true;
                        } else if (TV_isTakingBreakAtPresent) {
                          TV_studied_last_time = false;
                        }
                        TV_isStudyingAtPresent = false;
                        TV_isTakingBreakAtPresent = false;
                        TV_isTimerCheckerRunning = false;
                        TV_isMainTimerWorking = false;

                        try{
                          STATE_TopTimerWidget!(() {});
                        } catch(e){
                          customPrint('error as state didn\'t existed on the reset pomondoro of the top timer',object2: e);
                        }
                        STATE_timerClockRunningPage!(() {});
                      },
                      icon: Icon(Icons.restore),
                      label: Text('Reset Pomondoro')),
                ),
                //Start
                Visibility(
                  visible:
                      !TV_isMainTimerWorking | TV_isTimerPaused,
                  child: FlatButton.icon(
                      onPressed: () {
                        // customPrint('Start Button Working');
                        if (!TV_isMainTimerWorking) {
                          TV_isMainTimerWorking = true;
                        } else if (TV_isTimerPaused) {
                          TV_isTimerPaused = false;
                          // customPrint('made TV_isTimerPaused false');
                        }
                        STATE_timerClockRunningPage!(() {});
                      },
                      icon: Icon(Icons.double_arrow_rounded),
                      label: Text('Start Pomondoro')),
                ),
                // Pause
                Visibility(
                  visible:
                      TV_isMainTimerWorking && !TV_isTimerPaused,
                  child: FlatButton.icon(
                      onPressed: () {
                        // isMainTimerWorking = false;
                        if (TV_checkerTimer!.isActive) {
                          TV_checkerTimer!.cancel();
                        }
                        TV_isTimerCheckerRunning = false;
                        TV_isTimerPaused = true;
                        STATE_timerClockRunningPage!(() {});
                      },
                      icon: Icon(Icons.pause_rounded),
                      label: Text('Pause Pomondoro')),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            SizedBox(
              height: 70,
            )
          ],
        ));
  }
}

List pomondoroList = [
  {
    'id': 1,
    'timer_name': 'Study X',
    'time_of_study': Duration(minutes: 50).inSeconds,
    'time_of_break': Duration(minutes: 10).inSeconds
  },
  {
    'id': 2,
    'timer_name': 'Study N',
    'time_of_study': Duration(minutes: 25).inSeconds,
    'time_of_break': Duration(minutes: 5).inSeconds
  }
];
