// void onTimerComplete(){

// // debugPrint('done with timer ------------------------');
//             if (TV_isStudyingAtPresent) {
//               TV_studied_last_time = true;
//             } else if (TV_isTakingBreakAtPresent) {
//               TV_studied_last_time = false;
//             }
//             TV_isStudyingAtPresent = false;
//             TV_isTakingBreakAtPresent = false;
//             TV_isTimerCheckerRunning = false;
//             TV_isMainTimerWorking = false;
//             TV_timeSpent = Duration.zero;

//             if (TV_studied_last_time){
//               updateTimeStudiedInDB(
//                     database: gapv_dbInstance!,
//                     date: dateTimeIn_dd_mm_yyyy_formatNow(),
//                     studyTimeToBeAdded: TV_howLong)
//                 .then((value) => () async {
//                       customPrint('alpha 1');
//                       TV_studiedTime =
//                           await getHoursStudiedFromDayLoggerDB(
//                               date: dateTimeIn_dd_mm_yyyy_formatNow(),
//                               database: gapv_dbInstance!);
//                       customPrint('alpha 2');
//                       customPrint(TV_studiedTime);

//                       TV_setState_TOP_TIMER_WIDGET_func(() {});
//                       customPrint('alpha 3');
//                     }.call());
//             }

//             timerCompleteDailog();

//             showTimerCompleteNotification(
//                 message_to_show:
//                     '${durationToStringTime(duration: TV_howLong)} timer has completed');
//             timer.cancel();
//             TV_howLong = Duration.zero;
//             TV_setState_TOP_TIMER_WIDGET_func(() {});
//             if (TV_setState_c_func.toString() != 'Closure: () => Null') {
//               try {
//                 TV_setState_c_func(() {});
//               } catch (e) {
//                 customPrint(e,
//                     object2:
//                         'ERROR  ERROR  ERROR  ERROR  ERROR  ERROR  ERROR  ');
//               }
//             }








// }

// void onTimerRunning(){}

// void onTimerStart(){}