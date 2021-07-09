import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lecture_progress/resources/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/temp_variables_timer.dart'
    as temp_t_v;

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
              visible: !temp_t_v.isMainTimerWorking,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      temp_t_v.howLong =
                          Duration(seconds: pomondoroList[0]['time_of_study']);
                      temp_t_v.setState_c_func(() {});
                      temp_t_v.isStudyingAtPresent = true;
                      temp_t_v.isTakingBreakAtPresent = false;
                    },
                    onDoubleTap: () {
                      temp_t_v.howLong =
                          Duration(seconds: pomondoroList[0]['time_of_break']);
                      temp_t_v.setState_c_func(() {});
                      temp_t_v.isStudyingAtPresent = false;
                      temp_t_v.isTakingBreakAtPresent = true;
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
                      temp_t_v.howLong =
                          Duration(seconds: pomondoroList[1]['time_of_study']);
                      temp_t_v.setState_c_func(() {});
                      temp_t_v.isStudyingAtPresent = true;
                      temp_t_v.isTakingBreakAtPresent = false;
                    },
                    onDoubleTap: () {
                      temp_t_v.howLong =
                          Duration(seconds: pomondoroList[1]['time_of_break']);
                      temp_t_v.setState_c_func(() {});
                      temp_t_v.isStudyingAtPresent = false;
                      temp_t_v.isTakingBreakAtPresent = true;
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
                        if (temp_t_v.isStudyingAtPresent){
                          temp_t_v.studied_last_time = true;
                        } else if (temp_t_v.isTakingBreakAtPresent) {
                          temp_t_v.studied_last_time = false;
                        }
                        temp_t_v.isStudyingAtPresent = false;
                        temp_t_v.isTakingBreakAtPresent = false;
                        temp_t_v.isTimerCheckerRunning = false;
                        temp_t_v.isMainTimerWorking = false;

                        try{
                          temp_t_v.setState_TOP_TIMER_WIDGET_func(() {});
                        } catch(e){
                          customPrint('error as state didn\'t existed on the reset pomondoro of the top timer',object2: e);
                        }
                        temp_t_v.setState_c_func(() {});
                      },
                      icon: Icon(Icons.restore),
                      label: Text('Reset Pomondoro')),
                ),
                //Start
                Visibility(
                  visible:
                      !temp_t_v.isMainTimerWorking | temp_t_v.isTimerPaused,
                  child: FlatButton.icon(
                      onPressed: () {
                        // customPrint('Start Button Working');
                        if (!temp_t_v.isMainTimerWorking) {
                          temp_t_v.isMainTimerWorking = true;
                        } else if (temp_t_v.isTimerPaused) {
                          temp_t_v.isTimerPaused = false;
                          // customPrint('made temp_t_v.isTimerPaused false');
                        }
                        temp_t_v.setState_c_func(() {});
                      },
                      icon: Icon(Icons.double_arrow_rounded),
                      label: Text('Start Pomondoro')),
                ),
                // Pause
                Visibility(
                  visible:
                      temp_t_v.isMainTimerWorking && !temp_t_v.isTimerPaused,
                  child: FlatButton.icon(
                      onPressed: () {
                        // isMainTimerWorking = false;
                        if (temp_t_v.checkerTimer!.isActive) {
                          temp_t_v.checkerTimer!.cancel();
                        }
                        temp_t_v.isTimerCheckerRunning = false;
                        temp_t_v.isTimerPaused = true;
                        temp_t_v.setState_c_func(() {});
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
